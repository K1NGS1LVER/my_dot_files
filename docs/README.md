# Dotfiles Documentation Hub

> _Central navigation index, architecture guide, and repository directory taxonomy for this Apple Silicon development environment._

This directory serves as the documentation authority for the repository. Every configuration file in this repository is symlinked to the user's `$HOME` directory and managed through declarative scripts.

---

## 1. Documentation Index

> _A structured breakdown of all reference manuals, onboarding guides, and operational playbooks available in this repository._

| Document                                  | Focus Area                            | Target Audience & Use Case                                                                                                                                                          |
| :---------------------------------------- | :------------------------------------ | :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **[README.md](../README.md)**             | **Primary System Manual**             | Comprehensive architecture specification, system component breakdown, Mermaid system diagram, and core invariants.                                                                  |
| **[docs/CHEATSHEET.md](CHEATSHEET.md)**   | **Daily Command & Keybinding Matrix** | High-frequency keystroke reference covering directory navigation, project switching (`ts`), AeroSpace tiling, Zellij/Tmux modes, and Neovim 0.12 native LSP actions.                |
| **[docs/SETUP_GUIDE.md](SETUP_GUIDE.md)** | **Machine Onboarding & Bootstrap**    | Complete 4-step bootstrap runbook for fresh macOS machines: Xcode CLT, Homebrew bundle, declarative 37-symlink manifest deployment, cache compilation, and diagnostic verification. |
| **[CLAUDE.md](../CLAUDE.md)**             | **Agent Memory & Learned Fixes**      | Operational rules, hard invariants, and chronological ledger of system-specific engineering fixes for AI coding agents.                                                             |

---

## 2. Core Architectural Tenets

> _Foundational engineering principles that dictate how tools are chosen, configured, and maintained across this repository._

1. **Ponytail Philosophy (Ruthless Simplicity)**:
    - Prefer standard library implementations over external dependencies.
    - Use platform-native tools and operating system APIs before introducing custom scripts.
    - Eliminate dead code, unused plugins, and speculative abstractions immediately.

2. **Single Source of Truth (`shell/shared/`)**:
    - Configuration is never duplicated across shells. Canonical PATH precedence, environment variables, aliases, and theme registries reside in `shell/shared/`.
    - Zsh, Nushell, Bash, and Fish source their common definitions from this shared layer to maintain muscle memory across all environments.

3. **Strict Symlink Management**:
    - All files under `$HOME` that belong to this environment are symlinks pointing back into this repository.
    - The repository is the sole editing target. Never modify deployed symlinks in `$HOME`.
    - Symlink deployment is fully declarative and idempotent, driven by [scripts/lib/manifest.sh](../scripts/lib/manifest.sh).

4. **Separation of Configuration and Runtime State**:
    - Git tracks only static configuration.
    - Dynamic runtime state—shell history databases (`*.sqlite3*`), binary caches (`*.mdb`), socket files, plugin caches, and active theme stamps—are strictly gitignored.

---

## 3. Repository Directory Taxonomy

> _Detailed mapping of repository packages, configuration folders, and their operational roles._

```
dotfiles/
├── aerospace/            # AeroSpace i3-like tiling window manager configuration
├── bash/                 # Bash login and interactive fallback configuration
├── bat/                  # Syntax-highlighted cat replacement configuration and themes
├── btop/                 # System and resource monitor configuration
├── fish/                 # Fish shell interactive configuration
├── ghostty/              # Primary GPU-accelerated terminal configuration
├── git/                  # Global git configuration, aliases, and diff tool settings
├── launchd/              # macOS LaunchAgents for background daemon environment variables
├── nvim/                 # Neovim 0.12 IDE configuration (NvChad base, native LSP)
├── raycast/              # Raycast launcher scripts and extension configurations
├── scripts/              # Standalone maintenance, deployment, and diagnostic scripts
│   ├── lib/              # Shared shell libraries and manifest definitions
│   ├── deploy            # Idempotent symlink deployment engine
│   ├── doctor            # Comprehensive 28-point automated diagnostic suite
│   ├── tmux-sessionizer  # Project discovery and session manager (ts / tms)
│   ├── update-brew       # Declarative Homebrew bundle update and cleanup
│   └── nu-regen-cache    # Nushell pre-compiled cache regeneration
├── shell/                # Multi-shell architecture root
│   ├── shared/           # Single source of truth (paths, env, aliases, themes)
│   ├── zsh/              # Zsh login profile, interactive RC, and custom functions
│   └── nushell/          # Nushell environment, config, and structured modules
├── starship/             # Cross-shell prompt configuration (.config/starship.toml)
├── tmux/                 # Secondary tmux multiplexer configuration
├── yazi/                 # Async terminal file manager configuration and previewers
└── zellij/               # Primary terminal workspace manager configuration and layouts
```

---

## 4. Operational Runbooks & Diagnostics

> _Standardized commands to maintain repository health, apply updates, and verify system integrity._

- **Verify System Health**:

    ```zsh
    doctor
    ```

    Executes [scripts/doctor](../scripts/doctor) to validate all 37 manifest symlinks, syntax in Zsh and Nushell, Neovim headless startup, active LSP binaries, AeroSpace rules, and theme consistency.

- **Apply Symlink Updates**:

    ```zsh
    deploy
    ```

    Executes [scripts/deploy](../scripts/deploy) to idempotently synchronize the filesystem with the manifest. Previews can be run via `deploy --dry-run`.

- **Regenerate Shell Caches**:

    ```zsh
    nu-regen-cache
    ```

    Re-compiles Nushell startup init caches (`carapace`, `fzf`, `starship`, `zoxide`) in `~/.cache/` to ensure sub-20ms cold start performance.

- **Switch Global Themes**:
    ```zsh
    theme-switch monokai-pro
    ```
    Coordinates color palette changes across Ghostty, Neovim, Yazi, Zellij, Tmux, Zsh, and Nushell using [registry.tsv](../shell/shared/themes/registry.tsv).
