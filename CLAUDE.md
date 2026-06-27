# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repository is

This is the NEMTUS organization's special `.github` repository. GitHub treats it as a source of
**organization-wide defaults**, not as an application. There is no build, test, or lint tooling —
changes are plain text/config files that GitHub renders or applies automatically.

NEMTUS is a non-profit promoting the NEM/Symbol blockchain. The org's actual code (SDKs, event
web apps, blogs) lives in *other* repositories linked from `profile/README.md`.

## Files and their effect

- `profile/README.md` — Rendered publicly on the organization's GitHub profile page
  (`github.com/nemtus`). This is the most visible file; edits change what visitors see. Keep the
  cross-repo links to NEMTUS projects (SDKs, Hackathon, Tech Fest, blogs, techbooks) accurate.
- `FUNDING.yml` — Drives the "Sponsor" button across org repos. Only `github: [nemtus]` is active;
  the other platforms are commented placeholders.
- `README.md` — Describes the repo itself (not org-facing). Recent git history shows this is the
  file most often touched.
- `LICENSE` — MIT.

Note: `README.md` (repo-level) and `profile/README.md` (org profile) are distinct and serve
different audiences — don't conflate them when editing.

## Working conventions

- The default branch is `main`; changes typically land via PR (see existing merged PRs in history).
- When updating project links in `profile/README.md`, verify the target repos/sites still exist,
  since these are external references that drift over time.
