# Dotfiles

This repo is the live source of truth for the machine's symlinked config.

The layout mirrors the target paths:
- top-level dotfiles live in package folders such as `zsh/.zshrc`, `tmux/.tmux.conf`, and `aerospace/.aerospace.toml`
- app configs live under `<package>/.config/<app>`

Current primary stack:
- terminal: Ghostty
- multiplexer: Zellij
- shell: Zsh, with Fish and Nushell kept in sync where practical
- editor: Neovim
- file manager: Yazi
- window manager: AeroSpace

Compatibility configs are intentionally kept for:
- `kitty`
- `tmux`
- `mini`

Docs:
- [`docs/README.md`](/Users/dan/dotfiles/docs/README.md)
- [`docs/SETUP_GUIDE.md`](/Users/dan/dotfiles/docs/SETUP_GUIDE.md)
- [`docs/CHEATSHEET.md`](/Users/dan/dotfiles/docs/CHEATSHEET.md)

Rule of thumb:
- edit the repo targets, not the symlink destinations
- keep symlink paths stable
- do not commit runtime databases, caches, backups, or downloaded extension bundles
