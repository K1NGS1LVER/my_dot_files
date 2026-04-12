# Setup Guide

This repo assumes an existing symlink-based layout. Keep the current targets stable and relink to the repo if anything drifts.

## Install Core Packages

```sh
brew bundle --file ~/dotfiles/Brewfile
```

## Core Symlinks

```sh
ln -sfn ~/dotfiles/zsh/.zshrc ~/.zshrc
ln -sfn ~/dotfiles/tmux/.tmux.conf ~/.tmux.conf
ln -sfn ~/dotfiles/aerospace/.aerospace.toml ~/.aerospace.toml
```

For app configs, the repo mirrors `~/.config`:

```sh
ln -sfn ~/dotfiles/ghostty/.config/ghostty ~/.config/ghostty
ln -sfn ~/dotfiles/nvim/.config/nvim ~/.config/nvim
ln -sfn ~/dotfiles/yazi/.config/yazi ~/.config/yazi
ln -sfn ~/dotfiles/nushell/.config/nushell ~/.config/nushell
ln -sfn ~/dotfiles/fish/config.fish ~/.config/fish/config.fish
ln -sfn ~/dotfiles/starship/.config/starship.toml ~/.config/starship/starship.toml
```

## Primary Workflow

- terminal: Ghostty
- multiplexer: Zellij
- main shell: Zsh
- editor: Neovim

`kitty`, `tmux`, and `mini` are kept as compatibility paths and should remain linkable.

## After Editing

```sh
exec zsh
aerospace reload-config
tmux source-file ~/.tmux.conf
```

For Neovim, open it and run the usual health or plugin sync commands if needed.
