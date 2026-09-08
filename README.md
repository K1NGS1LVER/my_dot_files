# Dotfiles

> **One-Liner**: *Single-source-of-truth macOS dotfiles engineered for sub-10ms shell startup, universal multi-shell navigation, and a 35ms native Neovim 0.12 IDE experience.*

Symlink-driven configuration repository tailored for Apple Silicon (M2 MacBook Air). The repository is the single source of truth—all modifications occur here, never at deployed destination symlinks in `$HOME`. Built on the **Ponytail** engineering philosophy: zero unrequested abstractions, platform features before dependencies, standard library before custom code, and ruthless elimination of dead code.

---

## 1. Primary Stack

> **One-Liner**: *A minimalist, keyboard-driven development environment combining Ghostty, Zellij, dual primary shells (Zsh & Nushell), and native Neovim 0.12.*

| Layer | Primary Tool | Rationale & Architecture |
| :--- | :--- | :--- |
| **Terminal** | **Ghostty** | Hardware-accelerated terminal with native macOS rendering, Kitty graphics protocol support, and blur/opacity control. |
| **Multiplexer** | **Zellij** | Modern terminal workspace manager with native layout definitions (`zellij/.config/zellij`) and tab auto-renaming. (Tmux kept as a secondary compatibility fallback). |
| **Shells** | **Zsh** + **Nushell** | Symmetric primary environments: Zsh for standard POSIX/scripting compatibility; Nushell for structured, tabular data operations. Backed by synchronized Bash and Fish configurations. |
| **Editor** | **Neovim** | NvChad base modernized to Neovim 0.12 native LSP APIs (`vim.lsp.config`, `vim.lsp.enable`), zero-startup background Copilot, and sub-37ms cold startup. |
| **File Manager** | **Yazi** | Blazing-fast async terminal file manager with directory previews, image rendering, and bidirectional cwd synchronization (`y`). |
| **Window Manager**| **AeroSpace** | i3-like tiling window manager for macOS with deterministic workspace assignment and multi-display management. |
| **Prompt** | **Starship** | Fast cross-shell prompt with unified configuration (`.config/starship.toml`) shared across Zsh, Nushell, Bash, and Fish. |

---

## 2. Multi-Shell Architecture & Synchronization

> **One-Liner**: *A single source of truth in `shell/shared/` synchronizing paths, environment variables, and lean aliases across Zsh, Nushell, Bash, and Fish.*

All four shells draw their core definitions from a unified shared layer to prevent drift and preserve muscle memory regardless of which shell is active:

```
shell/
├── shared/                       # Single Source of Truth
│   ├── paths.zsh / paths.nu      # Canonical PATH precedence (scripts -> homebrew -> user bins)
│   ├── env.zsh / env.nu          # Environment variables (EDITOR, MANPAGER, PNPM_HOME)
│   ├── aliases.zsh / aliases.nu  # Pruned, high-signal aliases shared across all shells
│   ├── themes/                   # Theme registry (registry.tsv) + palette maps
│   └── browser-sites.zsh         # URL shortcuts for search launchers
├── zsh/
│   ├── .zprofile                 # Login initialization: Homebrew shellenv + shared paths/env
│   ├── .zshrc                    # Interactive config: completion caching, plugins, tool hooks
│   └── functions/                # Specialized function modules (tools, qol, docker, welcome)
└── nushell/
    ├── env.nu                    # Nushell login environment & tool init cache bootstrap
    ├── config.nu                 # Nushell interactive configuration & module loader
    └── modules/                  # Parity Nushell implementations (docker, qol, tools)
```

### Path Precedence Order
Defined identically in [paths.zsh](shell/shared/paths.zsh) and [paths.nu](shell/shared/paths.nu):
1. `$HOME/dotfiles/scripts` (Custom repository scripts)
2. `/opt/homebrew/bin` & `/opt/homebrew/sbin` (Homebrew packages)
3. `/usr/local/bin` & `/usr/bin` (System utilities)
4. `$HOME/.local/bin` & `$HOME/.cargo/bin` (User & Rust binaries)
5. Tool-specific bins (pnpm, Go, OpenJDK, Android Studio)

---

## 3. Core Daily Workflows & Shortcuts

> **One-Liner**: *High-frequency shortcuts designed for instant muscle memory and zero keystroke waste.*

### Directory Navigation
- `..` → `cd ..` (Up one directory level)
- `...` → `cd ../..` (Up two directory levels)
- `....` → `cd ../../..` (Up three directory levels)
- `home` → `cd ~`
- `c` → `clear`

### Project Session Switching (`ts`)
- **Command**: `ts` (or `tms`)
- **In-Depth**: Launches [scripts/tmux-sessionizer](scripts/tmux-sessionizer) with an interactive `fzf` picker across `~/projects` (up to 2 levels deep) and `~/dotfiles`. Automatically normalizes session names and seamlessly attaches or switches the active tmux/zellij session.

### Editor & Notes
- `v` or `vim` → Launches Neovim (`nvim`).
- `nvconfig` → Opens `~/.config/nvim/` directly.
- `notes` → Opens the Obsidian notes vault via `clin --vault ~/notes`.
- `mini` → Launches minimal vanilla Neovim profile (`NVIM_APPNAME=mini`).

### File Manager CWD Sync (`y`)
- **Command**: `y`
- **In-Depth**: Launches Yazi with a temporary tracking file. When you navigate through directories and exit with `q`, your shell's current working directory automatically changes to Yazi's last focused folder.

### Smart File Opener (`open`)
- **Command**: `open <file>`
- **In-Depth**: Context-aware dispatcher with native macOS flag passthrough (`open -a`, `open -R`, `open -h` pass directly to `/usr/bin/open`). File paths without flags dispatch by extension:
  - Code/text (`.py`, `.ts`, `.lua`, `.rs`, `.json`, `.md`) → opens in Neovim.
  - Documents (`.pdf`) → opens in Sioyek in a new window.
  - Media (`.mp4`, `.mkv`, `.mp3`) → opens in IINA.
  - Fallback → system default application.

---

## 4. Diagnostics & Maintenance Scripts

> **One-Liner**: *Automated diagnostic and deployment suite ensuring repository integrity in a single command.*

- **System Health Check**:
  ```zsh
  doctor  # or ./scripts/doctor
  ```
  Runs 28 automated checks validating symlink targets, Nushell syntax, Zsh syntax and hook order, Neovim headless startup and checkhealth, active Mason LSP server availability, AeroSpace configuration, and theme consistency.
- **Symlink Deployment**:
  ```zsh
  deploy  # or ./scripts/deploy [--dry-run]
  ```
  Idempotently creates or repairs every symlink specified in [scripts/lib/manifest.sh](scripts/lib/manifest.sh). Backs up replaced destinations to `~/.dotfiles-backup/<timestamp>/`.
- **Unified Theme Switcher**:
  ```zsh
  theme-switch [theme_name]  # or switch-theme
  ```
  Switches active color palettes across Ghostty, Kitty, Neovim, Yazi, Tmux, Zsh, and Nushell using [registry.tsv](shell/shared/themes/registry.tsv).
- **Homebrew Updates**:
  ```zsh
  update-brew  # updates bundle and cleans ghost packages
  ```

---

## 5. Invariants & Rules

> **One-Liner**: *Strict repository constraints to prevent drift, data loss, and history bloat.*

1. **Edit Repo Files Only**: Never edit deployed symlinks under `$HOME`. Always edit files within `/Users/dan/dotfiles`.
2. **Safe Deletions**: Always move obsolete files to `~/.Trash` rather than using `rm` or `rm -rf`.
3. **No Committed Runtime State**: Never commit history databases (`*.sqlite3*`), binary caches (`*.mdb`), backup copies (`*.bak*`), or temporary files.
4. **Shell Hook Invariants**: In `.zshrc`, `welcome-message` must remain the absolute final command so zoxide's trailing prompt hook requirement remains satisfied.
5. **Keep Package Folders Stable**: Do not rename top-level package directories without updating [scripts/lib/manifest.sh](scripts/lib/manifest.sh) and running `deploy`.

---

## 6. Documentation Reference

- [docs/CHEATSHEET.md](docs/CHEATSHEET.md) — Comprehensive quick-reference cheatsheet for daily terminal commands and keybindings.
- [docs/SETUP_GUIDE.md](docs/SETUP_GUIDE.md) — Complete 4-step bootstrap, recovery, and onboarding guide for fresh machines.
