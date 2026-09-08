# Setup & Bootstrap Guide

> **One-Liner**: *Deterministic 4-step bootstrap sequence for cloning, installing, linking, and verifying this entire dotfiles setup on a fresh Apple Silicon machine.*

Follow this guide when onboarding a new Mac or recovering your environment from scratch.

---

## 1. Package Installation (Homebrew)

> **One-Liner**: *Installs all GUI casks, CLI binaries, fonts, and compiler toolchains declared in the single declarative Brewfile.*

Run the bundle installer from your repository root:
```zsh
brew bundle --file ~/dotfiles/Brewfile
```

### In-Depth Details
- **Untrusted Taps**: If Homebrew reports `Refusing to load formula/cask from untrusted tap` (due to `HOMEBREW_REQUIRE_TAP_TRUST`), explicitly trust the required taps:
  ```zsh
  brew trust d99kris/nchat
  brew trust mongodb/brew
  brew trust steipete/tap
  ```
- **Formula vs Casks**: All core developer binaries (like `eza`, `bat`, `fzf`, `starship`, `yazi`, `zellij`, `sd`, `dust`, `procs`) and GUI applications (`Ghostty`, `AeroSpace`, `Firefox`, `Sioyek`, `IINA`) are versioned declaratively in [Brewfile](file:///Users/dan/dotfiles/Brewfile).

---

## 2. Symlink Deployment (`scripts/deploy`)

> **One-Liner**: *Idempotent link engine that maps all repository folders into `$HOME` based on `scripts/lib/manifest.sh`.*

Deploy all configurations:
```zsh
~/dotfiles/scripts/deploy
```

### In-Depth Details
- **Dry-Run Mode**: Preview exact planned filesystem changes before touching disk:
  ```zsh
  ~/dotfiles/scripts/deploy --dry-run
  ```
- **Automated Backups**: If a destination file already exists as a non-symlink, `deploy` moves it safely into `~/.dotfiles-backup/<timestamp>/` before creating the symlink.
- **Zellij & Dotfiles Tracking**: `zellij/.config/zellij` is symlinked directly into `~/.config/zellij`.
- **Nushell Architecture Invariant**: Unlike other tools, `~/.config/nushell` remains a **real directory** on disk because Nushell writes runtime session history (`history.sqlite3*`) next to its config. Only `config.nu` and `env.nu` inside it are symlinked to the repo.
- **Obsolete Cleanup**: Links marked in `OBSOLETE_LINKS` (like `.config/gtk-3.0` and `.config/simple-update-notifier`) are automatically retired.
- **Theme State Materialization**: `deploy` calls `scripts/switch-theme --ensure` to bootstrap the active palette from [default-theme](file:///Users/dan/dotfiles/shell/shared/themes/default-theme) if missing.

---

## 3. Nushell Init Caching

> **One-Liner**: *Generates pre-compiled shell initialization files to guarantee instant sub-20ms Nushell startup.*

Nushell loads pre-generated cache scripts for external tools (`carapace`, `fzf`, `starship`, `zoxide`) located in `~/.cache/<tool>/init.nu`. While [env.nu](file:///Users/dan/dotfiles/shell/nushell/env.nu) self-heals any missing caches on shell launch, you can force a fresh regeneration at any time from inside Nushell:

```nu
nu-regen-cache
```

---

## 4. System Validation (`scripts/doctor`)

> **One-Liner**: *Single-command automated test suite running 28 comprehensive validation checks across your entire machine.*

Run the health check:
```zsh
doctor  # or ~/dotfiles/scripts/doctor
```

### In-Depth Details
`scripts/doctor` executes with `set -uo pipefail` and validates:
1. **Symlinks**: Every single manifest link resolves cleanly to an existing repository path, with zero broken symlinks under `~` or `~/.config`.
2. **Nushell**: Init caches exist, `nu -l` boots cleanly, and `nu-check` syntax passes for all 14 `.nu` files.
3. **Zsh**: Syntax passes for `.zshrc`, `.zprofile`, and all functions, and asserts that nothing is appended after `welcome-message` (preserving zoxide prompt hook integrity).
4. **Neovim**: Verifies clean headless launch (0 errors), mini profile health, `checkhealth lazy vim.provider`, treesitter main branch tracking, and markdown parse correctness.
5. **Theme Consistency**: Verifies all 7 theme artifacts (Ghostty, Kitty, Neovim, Yazi, Tmux, Zsh, Nushell) match the active theme in `registry.tsv`.
6. **LSP Servers**: Verifies the 6 daily Mason servers (`pyright`, `ruff`, `lua_ls`, `bashls`, `jsonls`, `ts_ls`) are installed, along with system `gopls` and `rust-analyzer`.
7. **AeroSpace**: Validates window manager syntax via `aerospace reload-config --dry-run`.
8. **Git**: Asserts working tree cleanliness.

---

## 5. Post-Edit Reload Commands

> **One-Liner**: *Quick reload triggers to apply configuration edits live without restarting terminal windows.*

| Layer | Reload Trigger |
| :--- | :--- |
| **Zsh** | `reload` (or `source ~/.zshrc`) |
| **Nushell** | `reload` (or `exec nu`) |
| **Fish** | `reload` (or `source ~/.config/fish/config.fish`) |
| **Bash** | `reload` (or `source ~/.bashrc`) |
| **AeroSpace** | `aerospace reload-config` |
| **Tmux** | `<prefix> R` (or `tmux source-file ~/.tmux.conf`) |
| **Starship** | Automatic on next prompt press |

---

## 6. Keeping Things Updated

> **One-Liner**: *Declarative update commands to keep Homebrew, plugins, and CLI tools synchronized.*

| Target | Command | In-Depth Behavior |
| :--- | :--- | :--- |
| **Homebrew** | `update-brew` | Updates formulas/casks and removes ghost casks whose `.app` bundles were manually deleted. |
| **Full System** | `up` | Updates Homebrew sequentially, followed by parallel asynchronous updates of npm, pnpm, pipx, bob, tldr, and notes sync. |
| **Neovim Plugins** | `:Lazy sync` | Synchronizes plugins inside Neovim; updates `lazy-lock.json`. |

---

## 7. Hard Invariants & Rules

> **One-Liner**: *Core architectural guardrails protecting stability and git cleanliness.*

1. **Source of Truth**: Always edit files inside `~/dotfiles/`. Never edit the symlinks in `$HOME`.
2. **Symmetry Rule**: When modifying aliases or environment variables, update the shared definitions in `shell/shared/` so Zsh, Nushell, Bash, and Fish remain synchronized.
3. **Zero Committed Bloat**: Never commit `*.sqlite3`, `*.bak`, `*.mdb`, or temporary cache files. Git is your version control.
4. **Safe Deletions**: Move deprecated files to `~/.Trash` instead of running destructive `rm` commands.
