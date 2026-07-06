#!/usr/bin/env bash
# Idempotent installer for the NEMTUS maintainer ops layer.
# Symlinks nemtus-ops into ~/.local/bin, installs the systemd user units, and
# enables the refresh/bundle timers. Safe to re-run after every update.
set -euo pipefail

here="$(cd "$(dirname "$0")" && pwd)"
mirrors="${NEMTUS_MIRRORS:-$HOME/mirrors}"

mkdir -p "$HOME/.local/bin" "$HOME/.config/systemd/user" \
         "$mirrors/git" "$mirrors/bundles" "$mirrors/images" "$mirrors/logs"

chmod +x "$here/nemtus-ops"
ln -sf "$here/nemtus-ops" "$HOME/.local/bin/nemtus-ops"

cp "$here"/systemd/nemtus-*.service "$here"/systemd/nemtus-*.timer "$HOME/.config/systemd/user/"
systemctl --user daemon-reload
systemctl --user enable --now nemtus-mirror-refresh.timer nemtus-bundle.timer

echo "installed:"
echo "  $HOME/.local/bin/nemtus-ops -> $here/nemtus-ops"
systemctl --user list-timers 'nemtus-*' --no-pager || true
echo
echo "next steps: nemtus-ops mirror-refresh && nemtus-ops bundle && nemtus-ops doctor"
