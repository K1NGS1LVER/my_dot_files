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
- Nushell init caches (`~/.cache/{carapace,fzf,starship,zoxide}/init.nu`) self-heal on shell startup (`shell/nushell/env.nu`) if missing; force a refresh with `nu-regen-cache`. Do not commit them.
- Shell config is symmetric: `shell/shared/*` is the single source of truth for both Zsh and Nushell. A change to one shell's behavior usually means editing the shared module, not one shell.
- `~/.config/nushell` must stay a real directory, never a whole-dir symlink: it holds live history next to the config. Only `config.nu`/`env.nu` inside it are symlinked (see `scripts/lib/manifest.sh`).
- All symlinks are created/repaired by `scripts/deploy`, driven by the manifest in `scripts/lib/manifest.sh`. Do not hand-create symlinks into `$HOME`; add a manifest entry instead.
- Theme identity lives only in `shell/shared/themes/registry.tsv`. Never add a second theme-name map (Ghostty display name, NvChad base46 id) anywhere else; extend the registry instead.
- The 5 per-app "active theme" files (kitty/ghostty/nvim/zsh/nu) are gitignored runtime state written by `scripts/switch-theme`, not config. Never commit them or hand-edit them.
- Neovim's notebook stack (molten/jupytext/quarto) runs on the pinned venv at `~/.venvs/nvim`, never the system/brew `python3`. Update it only via `scripts/update-notebook-env`, never `pip install` directly into it ad hoc.
- Run `scripts/doctor` after any change that touches symlinks, shell config, nvim config, the notebook env, themes, Brewfile, or AeroSpace. It is the single source of truth for "is this still working."

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
- 2026-07-04: nvim's `switch-theme` rewriting `active-theme.lua` never actually changed nvim's colors, because base46 only recompiles its cache on plugin (re)install, not when chadrc's theme value changes. Fixed in `init.lua` with a stamp-file comparison that forces `base46.load_all_highlights()` when the compiled theme differs from the requested one.
- 2026-07-04: this machine has `HOMEBREW_REQUIRE_TAP_TRUST` set, so any tap not explicitly trusted (`brew trust <tap>`) makes `brew bundle`/`brew bundle check` fail outright with "Refusing to load formula/cask from untrusted tap." If brew commands fail mysteriously, check this first before assuming the Brewfile is broken.
- 2026-07-04: upgrading the AeroSpace cask via brew while AeroSpace.app is running leaves the CLI talking to a stale server (protocol version mismatch, `aerospace reload-config` fails). Fix: quit and relaunch AeroSpace.app after any brew upgrade that touches it.
- 2026-07-04: `nvim-treesitter`'s `master` branch is frozen upstream (May 2025), officially supporting only up to Neovim 0.12 with no further fixes. On Neovim 0.12.3 this crashed on markdown files with HTML image blocks (`query_predicates.lua` calling `get_node_text` on a stale node during injection). Migrated `plugins/treesitter.lua` + `nvim-treesitter-textobjects` to the `main` branch, which is a full rewrite (no more `.configs` module; highlight/indent enabled via `vim.treesitter.start()`/`indentexpr` on `FileType`, textobjects via explicit keymaps). Do not revert to `master`.
- 2026-07-04: two external installers (an Airflow project setup, Antigravity IDE) append raw `export` lines to the end of `.zshrc`, after zoxide's init, which breaks zoxide's "init must be last" check and prints a warning on every shell start. If this recurs, move the appended lines into the "Third-party installer appends" section near the top of `shell/zsh/.zshrc`, above External Tool Init. `scripts/doctor` checks for this now.
