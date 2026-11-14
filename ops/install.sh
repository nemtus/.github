#!/usr/bin/env bash
# Idempotent installer for the NEMTUS maintainer ops layer.
# Symlinks nemtus-ops into ~/.local/bin, installs the systemd user units, and
# enables the refresh/bundle timers. Safe to re-run after every update.
set -euo pipefail

#
# Paths: NEMTUS_SRC defaults to the directory holding this .github checkout (two levels above
# ops/), NEMTUS_MIRRORS to ~/mirrors. Both are written to ~/.config/nemtus-ops/env, which the
# systemd units load (EnvironmentFile) and nemtus-ops reads for interactive runs, so the
# checkout can live anywhere (e.g. ~/src/github/nemtus). Override at install time:
#   NEMTUS_SRC=/path/to/nemtus NEMTUS_MIRRORS=/path/to/mirrors ops/install.sh

here="$(cd "$(dirname "$0")" && pwd)"
src="${NEMTUS_SRC:-$(cd "$here/../.." && pwd)}"
mirrors="${NEMTUS_MIRRORS:-$HOME/mirrors}"
config="${XDG_CONFIG_HOME:-$HOME/.config}/nemtus-ops/env"

[ -d "$src/.github/.git" ] || { echo "error: $src has no .github checkout; set NEMTUS_SRC" >&2; exit 1; }

# Unit logs are fixed at ~/mirrors/logs (systemd's StandardOutput cannot expand variables).
mkdir -p "$HOME/.local/bin" "$HOME/.config/systemd/user" "$(dirname "$config")" \
         "$mirrors/git" "$mirrors/bundles" "$mirrors/images" "$mirrors/logs" "$HOME/mirrors/logs"

# Plain KEY="value" lines: valid both as a systemd EnvironmentFile and as shell.
printf '# Written by %s/install.sh — re-run it to change.\nNEMTUS_SRC="%s"\nNEMTUS_MIRRORS="%s"\n' \
  "$here" "$src" "$mirrors" > "$config"

chmod +x "$here/nemtus-ops"
ln -sf "$here/nemtus-ops" "$HOME/.local/bin/nemtus-ops"

cp "$here"/systemd/nemtus-*.service "$here"/systemd/nemtus-*.timer "$HOME/.config/systemd/user/"
systemctl --user daemon-reload
systemctl --user enable --now nemtus-mirror-refresh.timer nemtus-bundle.timer

echo "installed:"
echo "  $HOME/.local/bin/nemtus-ops -> $here/nemtus-ops"
echo "  $config: NEMTUS_SRC=$src NEMTUS_MIRRORS=$mirrors"
systemctl --user list-timers 'nemtus-*' --no-pager || true
echo
echo "next steps: nemtus-ops mirror-refresh && nemtus-ops bundle && nemtus-ops doctor"
