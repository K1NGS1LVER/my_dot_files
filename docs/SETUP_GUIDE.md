# Setup Guide

Bootstrap and recovery reference. Run these on a fresh machine or after a repo clone.

## 1. Install Packages

```zsh
brew bundle --file ~/dotfiles/Brewfile
```

## 2. Deploy Symlinks

### Shell

```zsh
ln -sf ~/dotfiles/shell/zsh/.zshrc ~/.zshrc
ln -sf ~/dotfiles/shell/zsh/.zprofile ~/.zprofile
ln -sf ~/dotfiles/shell/nushell/env.nu ~/.config/nushell/env.nu
ln -sf ~/dotfiles/shell/nushell/config.nu ~/.config/nushell/config.nu
```

### App Configs

```zsh
ln -sfn ~/dotfiles/ghostty/.config/ghostty ~/.config/ghostty
ln -sfn ~/dotfiles/nvim/.config/nvim ~/.config/nvim
ln -sfn ~/dotfiles/yazi/.config/yazi ~/.config/yazi
ln -sfn ~/dotfiles/starship/.config/starship.toml ~/.config/starship.toml
ln -sfn ~/dotfiles/aerospace/.aerospace.toml ~/.aerospace.toml
ln -sfn ~/dotfiles/tmux/.tmux.conf ~/.tmux.conf
```

### Compatibility (optional)

```zsh
ln -sfn ~/dotfiles/kitty/.config/kitty ~/.config/kitty
```

## 3. Generate Nushell Init Caches

Nushell sources pre-generated init files for carapace, fzf, starship, and zoxide. Generate them once after deploy:

```zsh
mkdir -p ~/.cache/carapace ~/.cache/fzf ~/.cache/starship ~/.cache/zoxide
carapace _carapace nushell > ~/.cache/carapace/init.nu
fzf --nushell > ~/.cache/fzf/init.nu
starship init nu > ~/.cache/starship/init.nu
zoxide init nushell --cmd cd > ~/.cache/zoxide/init.nu
```

Or from inside Nushell after first launch:

```nu
nu-regen-cache
```

Run `nu-regen-cache` again after upgrading any of those four tools.

## 4. Reload After Editing

| Shell | Command |
|---|---|
| Zsh | `exec zsh` or `reload` |
| Nushell | `exec nu` or `reload` |
| AeroSpace | `aerospace reload-config` |
| tmux | `tmux source-file ~/.tmux.conf` |
| Starship | Automatic on next prompt |

## Shell Architecture Reference

All shell config is under `~/dotfiles/shell/`. The shared modules are the single source of truth:

- `shared/paths.{zsh,nu}` — identical path order, edit both together
- `shared/env.{zsh,nu}` — identical env vars, edit both together
- `shared/aliases.{zsh,nu}` — unified alias map, edit both together
- `shared/catppuccin.{zsh,nu}` — Catppuccin Macchiato palette + FZF theme

Root configs (`zsh/.zshrc`, `nushell/config.nu`) are lean entry points that source the modules.

## Rules

- Edit the repo target, never the symlink destination.
- Do not commit: history databases (`*.sqlite3`), init caches (`~/.cache/*/init.nu`), backup files (`*.bak`), or plugin download bundles.
- Keep the `shell/shared/` pairs in sync — if you change `paths.zsh`, change `paths.nu` too.
