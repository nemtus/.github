# NEMTUS maintainer ops layer

Versioned home of the maintainer-machine tooling that keeps the NEMTUS mirror
operation healthy: local disaster-recovery mirrors of the upstream Symbol repos,
weekly bundle snapshots, and a `doctor` that answers "is my DR still alive" in one
command. Install with:

```bash
ops/install.sh            # symlink + systemd user timers (idempotent)
nemtus-ops setup-remotes  # fetch-only upstream remotes on the fork checkouts
nemtus-ops doctor         # verify everything
```

## What runs when

| Unit | Schedule | What it does |
| --- | --- | --- |
| `nemtus-mirror-refresh.timer` | daily 03:30 (+ random ≤45min, catch-up on boot) | `nemtus-ops mirror-refresh` — fetch upstream + fork into `~/mirrors/git/*.git` |
| `nemtus-bundle.timer` | Sun 07:15 (+ random ≤30min, catch-up on boot) | `nemtus-ops bundle` — full `git bundle` per mirror into `~/mirrors/bundles/<date>/`, keep 12 |
| `nemtus-notify@.service` | on failure of the above | append to `~/mirrors/logs/refresh.log` + desktop notification |

Paths: `NEMTUS_SRC` (org checkouts) defaults to the directory that holds this `.github`
checkout — wherever it is, e.g. `~/src/github/nemtus` — and `NEMTUS_MIRRORS` (DR data) to
`~/mirrors`. `install.sh` writes both to `~/.config/nemtus-ops/env`, which the systemd units
load (`EnvironmentFile`) and `nemtus-ops` reads for manual runs; a value set in the
environment still wins. To change them, re-run `install.sh` with the variables set
(`NEMTUS_SRC=… NEMTUS_MIRRORS=… ops/install.sh`). Unit logs always go to
`~/mirrors/logs/refresh.log`.

On WSL / machines without lingering, the timers only run while a user session is up;
`Persistent=true` catches up missed runs at the next login (`loginctl enable-linger` makes
them run without a login, if your system allows it).

## The DR mirror model

One bare repo per project (`symbol`, `symbol-networks`, `symbol-product`, `symbol-bootstrap`) with two
remotes fetched into separate namespaces:

- `refs/upstream/heads/*`, `refs/upstream/tags/*` ← `github.com/symbol/<project>`
- `refs/fork/heads/*`, `refs/fork/tags/*` ← `github.com/nemtus/<project>`

Properties that matter for disaster recovery:

- **Anonymous HTTPS** — refresh never depends on 1Password / SSH-agent / token state.
- **Append-biased** — `fetch.prune=false` (upstream deleting a branch does not delete
  our copy) and reflogs kept 180 days (`core.logAllRefUpdates=always`), so an
  upstream force-push leaves the old tip in the reflog = tamper evidence.
- **Bundles are full snapshots** — each `<date>/<project>.bundle` contains *all* refs
  (upstream + fork). Restore drill:

```bash
git clone ~/mirrors/bundles/<date>/symbol.bundle restored-symbol
git -C restored-symbol ls-remote origin   # shows refs/upstream/* and refs/fork/*
```

`~/mirrors/images/` holds `docker save` tarballs of the two `ghcr.io/nemtus` images
pinned by `symbol-networks/.github/network-config/versions.env`; `mirror-refresh`
warns (with the exact commands) when a pinned version has no tarball yet.

`symbol-bootstrap` is a maintenance fork that keeps using the upstream `symbolplatform/*`
Docker images; their copies are kept by CI (`image-backup.yml` in that repo →
`ghcr.io/nemtus/symbol-bootstrap-images/*`), not as local tarballs.

## nemtus-ops subcommands

- `status-all [--fetch] [--prs]` — one line per checkout: branch, dirty count,
  ahead/behind origin, ahead/behind the mirrored upstream ref, fetch age.
- `sync-local` — fast-forward-only update of every clean checkout (skips dirty ones);
  also fast-forwards the default branch when a feature branch is checked out, and
  pushes the upstream tag archive for `symbol`
  (`refs/remotes/upstream/tags/* -> refs/upstream/tags/*`). This is the
  maintainer-lane half of the tamper-alarm design: CI's `upstream-tags` job only
  VERIFIES, because GITHUB_TOKEN cannot create refs whose trees contain workflow
  files (see `symbol/RELEASE.md`, "Upstream tag archive").
- `setup-remotes` — idempotently gives each fork checkout a fetch-only `upstream` remote
  (`pushurl=DISABLED`; for `symbol` also upstream tags into `refs/remotes/upstream/tags/*`,
  the source `sync-local` archives). Run once on a new machine, after cloning.
- `mirror-refresh` / `bundle` — the timer payloads (bootstrap the mirrors on first run).
- `verify-parity` — runs each mirror repo's rename/invariant gate in a throwaway
  `git worktree` (never touches your working tree): `apply-nemtus-patch.sh` (symbol),
  `apply-nemtus-networks-patch.sh` (symbol-networks),
  `check-nemtus-mirror-invariants.sh` (symbol-product, symbol-bootstrap).
- `doctor` — identity, credential helper, GH_TOKEN validity/expiry, upstream
  `pushurl=DISABLED`, timers active, `git maintenance` registered, mirror freshness
  (<48h), newest bundle (<8d), disk space.

## Notes / caveats

- `git maintenance` prefetch (configured separately on the checkouts) fetches all
  remotes into `refs/prefetch/*` — visible `upstream/*` refs still update only on an
  explicit `git fetch upstream`. Don't be surprised by "instant" fetches.
- gh / git-push auth on this machine is `GH_TOKEN` sourced from 1Password by
  `~/.config/shell/gh-token.sh` (see the workspace `CLAUDE.md`). The DR units do NOT
  need it — that is deliberate.
- To stop a timer permanently: `systemctl --user disable --now <timer>` and remove
  the unit files; re-running `install.sh` reinstalls them.
