# Dotfiles

Symlink-driven config for an M2 MacBook Air. The repo is the single source of truth — edit here, never at the symlink destination.

## Primary Stack

| Layer | Tool |
|---|---|
| Terminal | Ghostty |
| Multiplexer | Zellij |
| Shells | **Zsh** (POSIX/scripting) + **Nushell** (data-driven interactive) — equal primaries |
| Editor | Neovim (NvChad) |
| File Manager | Yazi |
| Window Manager | AeroSpace |
| Prompt | Starship (shared config, both shells) |

Compatibility configs kept but not the primary path: `kitty`, `tmux`, `mini` Neovim profile.

## Shell Architecture

Zsh and Nushell are symmetric primary environments backed by a shared source-of-truth module layer:

```
shell/
├── shared/          # Single source of truth for both shells
│   ├── paths.zsh / paths.nu       # Identical path order
│   ├── env.zsh / env.nu           # Identical environment variables
│   ├── aliases.zsh / aliases.nu   # Unified alias map
│   ├── themes/                    # Per-theme palettes + registry.tsv + default-theme
│   └── browser-sites.zsh          # Browser URL registry
├── zsh/
│   ├── .zprofile                  # Login: brew shellenv + shared paths/env
│   ├── .zshrc                     # Interactive: plugins + function module sources
│   └── functions/                 # browser, yazi, system, multiplexer, tools, welcome
└── nushell/
    ├── env.nu                     # Sources shared/paths.nu + shared/env.nu
    ├── config.nu                  # Sources shared/aliases.nu + all modules
    └── modules/                   # browser, yazi, system, multiplexer, tools, docker, qol, welcome
```

## Layout Convention

The repo tree mirrors the target filesystem under `$HOME`:

- `shell/zsh/.zshrc` → `~/.zshrc`
- `shell/nushell/config.nu` → `~/.config/nushell/config.nu`
- `ghostty/.config/ghostty/` → `~/.config/ghostty/`
- etc.

All deployments are symlinks, created and repaired by `scripts/deploy` from the link manifest in `scripts/lib/manifest.sh`.
See [`docs/SETUP_GUIDE.md`](docs/SETUP_GUIDE.md) for the full bootstrap procedure.

Run `scripts/doctor` any time to check the whole setup in one pass: symlinks, both shells, Neovim, the notebook venv, theme consistency, Homebrew, LSP servers, and AeroSpace.

## Rules

- Edit the repo target, never the symlink destination.
- Keep symlink paths stable - don't rename package folders.
- Do not commit runtime state: history databases, caches, lock files, plugin bundles, theme state, or backup files.
- Nushell init caches (`~/.cache/{carapace,fzf,starship,zoxide}/init.nu`) self-heal on shell startup if missing, and can be forced with `nu-regen-cache`. Do not commit them.

## Docs

- [`docs/SETUP_GUIDE.md`](docs/SETUP_GUIDE.md) - bootstrap, deploy, doctor, update commands, post-edit reload commands
- [`docs/CHEATSHEET.md`](docs/CHEATSHEET.md) - daily commands and keybindings
