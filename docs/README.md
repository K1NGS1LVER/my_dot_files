# Dotfiles Docs

Reference documentation for the live dotfiles setup.

## Primary Stack

| Layer | Tool |
|---|---|
| Terminal | Ghostty |
| Multiplexer | Zellij |
| Shells | Zsh + Nushell (symmetric primary environments) |
| Editor | Neovim (NvChad) |
| File Manager | Yazi |
| Window Manager | AeroSpace |
| Prompt | Starship |

Compatibility configs exist for: Kitty, tmux, `mini` Neovim profile.

## Files in This Directory

| File | Purpose |
|---|---|
| [`SETUP_GUIDE.md`](SETUP_GUIDE.md) | Bootstrap, symlink table, cache generation, reload commands |
| [`CHEATSHEET.md`](CHEATSHEET.md) | Daily commands, aliases, and keybindings for both shells |

## Repository Conventions

- The repo tree mirrors the filesystem under `$HOME` and `~/.config`.
- All deployments are symlinks. Edit the repo target, never the destination.
- Shell config lives under `shell/` with shared modules as the single source of truth.
- Nushell init caches (`~/.cache/*/init.nu`) are generated locally, not tracked in git.
- Runtime state (history, databases, plugin bundles) stays out of git.
