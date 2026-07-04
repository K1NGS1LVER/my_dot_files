# CLAUDE.md — dotfiles

Project memory for agents working in this repo.
See `README.md` for the full stack and `docs/` for setup/cheatsheet.
This file holds agent-facing conventions and an accumulating log of learned fixes.

## What this repo is

Symlink-driven macOS (M2 MacBook Air) config.
The repo is the single source of truth: edit files here, never the deployed symlink target.

## Hard rules

- Edit the repo file, never the symlink destination under `$HOME`.
- Keep symlink paths stable: do not rename package folders.
- Never commit runtime state: history databases, caches, lock files, plugin bundles, backups.
- Nushell init caches (`~/.cache/{carapace,fzf,starship,zoxide}/init.nu`) are deploy-time generated. Do not commit them.
- Shell config is symmetric: `shell/shared/*` is the single source of truth for both Zsh and Nushell. A change to one shell's behavior usually means editing the shared module, not one shell.

## Stack quick reference

Terminal Ghostty. Multiplexer Zellij (tmux kept only as a compatibility config, not primary). Editor Neovim/NvChad. Shells Zsh + Nushell (equal primaries). WM AeroSpace. Prompt Starship.

## Agentic workflow tooling

This machine is being set up to follow Kun Chen's agentic engineering workflow (ByteByteGo: "An Ex-Meta L8's Agentic Engineering Setup").
Plan: `~/.claude/plans/wise-humming-valley.md`.

Verified-genuine tools installed (npm, by Kun): `gnhf`, `gh-axi`.
Tools that are Go-based / curl-installed (NOT npm — npm names are namesquats): `treehouse`, `no-mistakes`.
Orchestrator: `firstmate` (GitHub: `kunchenguid/firstmate`).
Prefer `gh-axi` over raw `gh`/GitHub MCP for GitHub work (lower tokens).

## Learned fixes

Append a dated bullet each time a non-obvious fix is discovered, so future sessions inherit it.

- 2026-07-01: npm packages `treehouse`, `no-mistakes` are unrelated namesquats. Kun's real versions are Go tools installed via the repo `install.sh` or `go install`. Only `gnhf` and `gh-axi` are genuine on npm.
