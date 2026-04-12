# Dotfiles Docs

This directory is the current documentation for the live dotfiles setup.

Primary tools:
- terminal: Ghostty
- multiplexer: Zellij
- shell: Zsh
- alternate shells: Fish, Nushell
- editor: Neovim
- file manager: Yazi
- window manager: AeroSpace

Compatibility configs are kept, but they are not the default path:
- Kitty
- tmux
- `mini` Neovim profile

Read these first:
- [`SETUP_GUIDE.md`](/Users/dan/dotfiles/docs/SETUP_GUIDE.md): recovery, relinking, and bootstrap notes
- [`CHEATSHEET.md`](/Users/dan/dotfiles/docs/CHEATSHEET.md): daily commands and keybindings

Repo conventions:
- the repo structure mirrors the existing symlink layout under `$HOME` and `~/.config`
- package folders are stable targets for those symlinks
- runtime data stays in the live app directories but should not stay tracked in git
