# Setup Guide

Bootstrap and recovery reference.
Run these on a fresh machine or after a repo clone.

## 1. Install Packages

```zsh
brew bundle --file ~/dotfiles/Brewfile
```

If this fails on an untrusted tap, trust the taps already listed in the Brewfile:

```zsh
brew trust <tap-name>
```

## 2. Deploy Symlinks

```zsh
~/dotfiles/scripts/deploy
```

This reads the link manifest in `scripts/lib/manifest.sh` and creates or repairs every symlink from the repo into `$HOME`.
It is idempotent: running it again with nothing to do reports zero pending actions.
Anything it replaces is backed up to `~/.dotfiles-backup/<timestamp>/` first.
Use `scripts/deploy --dry-run` to preview changes without applying them.

It also bootstraps the active theme state (`scripts/switch-theme --ensure`) if it is missing.

### Nushell is a special case

`~/.config/nushell` must be a real directory, not a symlink, because Nushell writes runtime history (`history.sqlite3*`) next to its config.
Only `config.nu` and `env.nu` inside it are symlinked into the repo; the rest is local state.

## 3. Generate Nushell Init Caches

Nushell sources pre-generated init files for carapace, fzf, starship, and zoxide.
`shell/nushell/env.nu` regenerates any that are missing automatically on shell startup, so this step is usually unnecessary.
To force a refresh after upgrading any of those four tools, run from inside Nushell:

```nu
nu-regen-cache
```

## 4. Set Up the Notebook Environment

The Neovim notebook stack (molten, jupytext, quarto) runs on a dedicated, pinned Python venv, not the system python3.

```zsh
~/dotfiles/scripts/setup-notebook-env
```

This creates `~/.venvs/nvim` from the versioned `python@3.13` Homebrew formula, installs the pinned packages in `nvim/.config/nvim/python-requirements.txt`, registers a Jupyter kernel named `nvim-venv`, and runs a smoke test.

## 5. Verify Everything

```zsh
~/dotfiles/scripts/doctor
```

Runs every check in one pass: symlinks, Nushell startup, Zsh syntax, Neovim startup and health, the notebook venv, theme consistency, Homebrew, LSP servers, AeroSpace, and repo cleanliness.
Each failure prints the exact command to fix it.

## 6. Reload After Editing

| Shell | Command |
|---|---|
| Zsh | `exec zsh` or `reload` |
| Nushell | `exec nu` or `reload` |
| AeroSpace | `aerospace reload-config` |
| tmux | `tmux source-file ~/.tmux.conf` |
| Starship | Automatic on next prompt |

## Keeping Things Updated

Each pinned layer has its own deliberate update command, so nothing drifts silently:

| Layer | Command |
|---|---|
| Nvim plugins | `update-nvim-plugins` |
| Notebook venv | `update-notebook-env` (or `--upgrade` to bump pins) |
| Homebrew | `update-brew` |

Each one verifies the result (health checks, smoke tests, or `brew bundle check`) before offering to commit.
`update-nvim-plugins` restores the previous `lazy-lock.json` automatically if the health check fails after updating.

## Shell Architecture Reference

All shell config is under `~/dotfiles/shell/`.
The shared modules are the single source of truth:

- `shared/paths.{zsh,nu}` - identical path order, edit both together
- `shared/env.{zsh,nu}` - identical env vars, edit both together
- `shared/aliases.{zsh,nu}` - unified alias map, edit both together
- `shared/themes/` - one `.zsh` + `.nu` file per theme, plus `registry.tsv` and `default-theme`

Root configs (`shell/zsh/.zshrc`, `shell/nushell/config.nu`) are lean entry points that source the modules.

## Theme Switching

```zsh
theme-switch          # fzf picker with live preview
theme-switch <name>   # switch directly, e.g. theme-switch gruvbox-dark
```

The active theme is runtime state, not config: `shell/shared/themes/registry.tsv` is the single source of truth for theme names across Kitty, Ghostty, and Neovim.
The 5 per-app "active theme" files it writes are gitignored, so switching themes never dirties the repo.
`scripts/switch-theme --ensure` bootstraps them from `shell/shared/themes/default-theme` if they are ever missing.

## Rules

- Edit the repo target, never the symlink destination.
- Do not commit: history databases (`*.sqlite3`), init caches (`~/.cache/*/init.nu`), backup files (`*.bak`), theme state files, or plugin download bundles.
- Keep the `shell/shared/` pairs in sync - if you change `paths.zsh`, change `paths.nu` too.
- To add a new theme, add one row to `registry.tsv` plus the per-app asset files; never hand-edit a name map elsewhere.
