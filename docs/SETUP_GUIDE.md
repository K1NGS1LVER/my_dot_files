# Setup & Bootstrap Guide

> _Deterministic bootstrap sequence for cloning, installing, linking, and verifying this entire dotfiles environment on a fresh Apple Silicon machine._

Follow this guide when setting up a new Mac or restoring your development environment from scratch.

---

## 1. Prerequisites & macOS Baseline Configuration

> _Essential developer toolchains and macOS system defaults configured prior to running package managers._

### Command Line Tools & Homebrew

On Apple Silicon, Homebrew installs into `/opt/homebrew`. Install the Apple developer command line tools, followed by the Homebrew package manager:

```zsh
# 1. Install Apple Command Line Tools
xcode-select --install

# 2. Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# 3. Add Homebrew to current shell path temporarily for bootstrap
eval "$(/opt/homebrew/bin/brew shellenv)"
```

### macOS System Preferences

Optimize macOS keyboard repeat rates and UI responsiveness:

```zsh
# Fast key repeat rate and low initial delay
defaults write -g InitialKeyRepeat -int 15
defaults write -g KeyRepeat -int 2

# Disable press-and-hold for keys in favor of key repeat
defaults write -g ApplePressAndHoldEnabled -bool false

# Disable window open and resize animations
defaults write -g NSAutomaticWindowAnimationsEnabled -bool false

# Speed up Mission Control animations
defaults write com.apple.dock expose-animation-duration -float 0.1
killall Dock
```

---

## 2. Package Installation (Homebrew)

> _Installs all GUI casks, CLI binaries, fonts, and compiler toolchains declared in the single declarative Brewfile._

Clone the repository into `$HOME/dotfiles`:

```zsh
git clone https://github.com/K1NGS1LVER/my_dot_files.git ~/dotfiles
```

### Tap Trust Requirements

This machine operates with `HOMEBREW_REQUIRE_TAP_TRUST` enabled. Any tap not explicitly trusted will cause `brew bundle` to fail outright with `Refusing to load formula/cask from untrusted tap`. Authorize the required third-party taps before proceeding:

```zsh
brew trust d99kris/nchat
brew trust mongodb/brew
brew trust steipete/tap
```

### Execute Bundle Installation

Install all CLI binaries, fonts (`font-jetbrains-mono-nerd-font`), and GUI applications (`Ghostty`, `AeroSpace`, `Firefox`, `Sioyek`, `IINA`):

```zsh
brew bundle --file ~/dotfiles/Brewfile
```

To maintain and clean stale dependencies later, run the repository maintenance script:

```zsh
~/dotfiles/scripts/update-brew
```

---

## 3. Symlink Deployment (`scripts/deploy`)

> _Idempotent link engine mapping all repository configuration folders into `$HOME` based on the declarative link manifest._

Every configuration in this repository is symlinked directly from `~/dotfiles` into `$HOME`.

### Execute Deployment

```zsh
# Optional: preview planned changes without touching disk
~/dotfiles/scripts/deploy --dry-run

# Execute idempotent symlinking
~/dotfiles/scripts/deploy
```

### Complete Symlink Manifest (37 Entries)

The deployment script reads [scripts/lib/manifest.sh](../scripts/lib/manifest.sh) and creates the following links:

| Category         | Repository Source                              | Target in `$HOME`                                             | Link Type         |
| :--------------- | :--------------------------------------------- | :------------------------------------------------------------ | :---------------- |
| **Shells**       | `shell/zsh/.zshrc`                             | `~/.zshrc`                                                    | File Symlink      |
|                  | `shell/zsh/.zprofile`                          | `~/.zprofile`                                                 | File Symlink      |
|                  | `bash/.bashrc`                                 | `~/.bashrc`                                                   | File Symlink      |
|                  | `shell/nushell/config.nu`                      | `~/.config/nushell/config.nu`                                 | File Symlink      |
|                  | `shell/nushell/env.nu`                         | `~/.config/nushell/env.nu`                                    | File Symlink      |
| **Home Files**   | `git/.gitconfig`                               | `~/.gitconfig`                                                | File Symlink      |
|                  | `tmux/.tmux.conf`                              | `~/.tmux.conf`                                                | File Symlink      |
|                  | `aerospace/.aerospace.toml`                    | `~/.aerospace.toml`                                           | File Symlink      |
|                  | `surfingkeys/.surfingkeys.js`                  | `~/.surfingkeys.js`                                           | File Symlink      |
|                  | `.prettierrc`                                  | `~/.prettierrc`                                               | File Symlink      |
|                  | `.hushlogin`                                   | `~/.hushlogin`                                                | File Symlink      |
|                  | `launchd/com.dan.ollama-flash-attention.plist` | `~/Library/LaunchAgents/com.dan.ollama-flash-attention.plist` | File Symlink      |
| **Config Files** | `starship/.config/starship.toml`               | `~/.config/starship.toml`                                     | File Symlink      |
|                  | `fish/config.fish`                             | `~/.config/fish/config.fish`                                  | File Symlink      |
|                  | `qutebrowser/config.py`                        | `~/.config/qutebrowser/config.py`                             | File Symlink      |
| **Config Dirs**  | `alacritty/.config/alacritty`                  | `~/.config/alacritty`                                         | Directory Symlink |
|                  | `bat/.config/bat`                              | `~/.config/bat`                                               | Directory Symlink |
|                  | `btop/.config/btop`                            | `~/.config/btop`                                              | Directory Symlink |
|                  | `epr/.config/epr`                              | `~/.config/epr`                                               | Directory Symlink |
|                  | `gh/.config/gh`                                | `~/.config/gh`                                                | Directory Symlink |
|                  | `ghostty/.config/ghostty`                      | `~/.config/ghostty`                                           | Directory Symlink |
|                  | `goose/.config/goose`                          | `~/.config/goose`                                             | Directory Symlink |
|                  | `iterm2/.config/iterm2`                        | `~/.config/iterm2`                                            | Directory Symlink |
|                  | `karabiner/.config/karabiner`                  | `~/.config/karabiner`                                         | Directory Symlink |
|                  | `kitty/.config/kitty`                          | `~/.config/kitty`                                             | Directory Symlink |
|                  | `mini/.config/mini`                            | `~/.config/mini`                                              | Directory Symlink |
|                  | `mozilla/.config/mozilla`                      | `~/.config/mozilla`                                           | Directory Symlink |
|                  | `mpv/.config/mpv`                              | `~/.config/mpv`                                               | Directory Symlink |
|                  | `nchat/.config/nchat`                          | `~/.config/nchat`                                             | Directory Symlink |
|                  | `nvim/.config/nvim`                            | `~/.config/nvim`                                              | Directory Symlink |
|                  | `qBittorrent/.config/qBittorrent`              | `~/.config/qBittorrent`                                       | Directory Symlink |
|                  | `raycast/.config/raycast`                      | `~/.config/raycast`                                           | Directory Symlink |
|                  | `sioyek/.config/sioyek`                        | `~/.config/sioyek`                                            | Directory Symlink |
|                  | `tmux/.config/tmux`                            | `~/.config/tmux`                                              | Directory Symlink |
|                  | `yazi/.config/yazi`                            | `~/.config/yazi`                                              | Directory Symlink |
|                  | `zed/.config/zed`                              | `~/.config/zed`                                               | Directory Symlink |
|                  | `zellij/.config/zellij`                        | `~/.config/zellij`                                            | Directory Symlink |

_Note: `~/.config/nushell` remains a real directory, not a directory symlink, because Nushell stores its live runtime history databases (`history.sqlite3*`) alongside its configuration._

---

## 4. Shell Initialization & Cache Generation

> _Generates pre-compiled shell initialization files to guarantee instant sub-20ms Nushell startup._

Nushell achieves sub-20ms cold-start times by loading pre-compiled initialization scripts rather than executing dynamic subshells on every startup. Generate these caches:

```zsh
~/dotfiles/scripts/nu-regen-cache
```

This compiles static files under `~/.cache/`:

- `~/.cache/carapace/init.nu` (command completions)
- `~/.cache/fzf/init.nu` (fuzzy picker integration)
- `~/.cache/starship/init.nu` (prompt integration)
- `~/.cache/zoxide/init.nu` (smart directory navigation)

If any cache file is absent, `shell/nushell/env.nu` will auto-generate it on startup, but running `nu-regen-cache` explicitly ensures immediate optimal performance.

---

## 5. Neovim 0.12 IDE Bootstrap

> _Headless plugin synchronization, parser compilation, and LSP server installation._

Run headless initialization commands to prepare Neovim without launching the interactive GUI:

```zsh
# 1. Synchronize plugins via Lazy.nvim
nvim --headless "+Lazy! sync" +qa

# 2. Compile Treesitter parsers
nvim --headless "+TSUpdateSync" +qa

# 3. Verify Mason LSP installations
nvim --headless "+MasonToolsInstall" +qa
```

---

## 6. Background Daemons & LaunchAgents

> _Persisting environment variables for GUI applications across system reboots via launchd._

GUI applications started via macOS Finder or Login Items do not read `.zshrc` or `.zprofile`. To ensure `OLLAMA_FLASH_ATTENTION=1` reaches GUI services, register the LaunchAgent symlinked in step 3:

```zsh
launchctl bootstrap "gui/$(id -u)" ~/Library/LaunchAgents/com.dan.ollama-flash-attention.plist
```

---

## 7. Diagnostics & Health Verification

> _Single-command automated test suite running 28 comprehensive validation checks across your entire machine._

Run the doctor script to verify the entire installation:

```zsh
~/dotfiles/scripts/doctor
```

Expected output:

```
======================================================================
doctor: 28 pass, 0 warn, 0 fail
```

Checks performed include:

1. Manifest symlinks (all 37 links verified pointing to existing repository targets).
2. Broken symlinks under `$HOME` and `~/.config`.
3. Nushell cache existence, config directory structure, and syntax check via `nu-check`.
4. Zsh syntax check via `zsh -n` and verification that `welcome-message` is the trailing command.
5. Neovim headless startup, checkhealth, main-branch treesitter parser parsing.
6. Theme consistency agreeing across all 7 application configurations.
7. Active Mason LSP server binaries installed and operational.
8. AeroSpace configuration syntax validation.
9. Clean git working directory state.

---

## 8. Live Configuration Reloads

> _Quick reload triggers to apply configuration edits live without restarting terminal windows._

| Component     | Reload Command                       | Behavior                                                |
| :------------ | :----------------------------------- | :------------------------------------------------------ |
| **Zsh**       | `source ~/.zshrc`                    | Reloads interactive functions, aliases, and environment |
| **Nushell**   | `source ~/.config/nushell/config.nu` | Reloads Nushell interactive environment                 |
| **AeroSpace** | `aerospace reload-config`            | Re-reads `~/.aerospace.toml` layout rules and gaps      |
| **Tmux**      | `tmux source ~/.tmux.conf`           | Reloads tmux keybindings and status bar                 |
| **Zellij**    | Automatic                            | Hot-reloads configuration changes upon file save        |
| **Ghostty**   | `Cmd+Shift+,`                        | Re-reads configuration file live                        |

---

## 9. Troubleshooting Playbook

> _Immediate resolutions for non-obvious system behaviors and common bootstrap edge cases._

### Homebrew Tap Trust Errors

- **Symptom**: `brew bundle` fails with `Refusing to load formula/cask from untrusted tap`.
- **Cause**: macOS environment variable `HOMEBREW_REQUIRE_TAP_TRUST=1` is enforced.
- **Fix**: Authorize the tap explicitly via `brew trust <tap/name>`, then re-run `brew bundle`.

### AeroSpace IPC Protocol Mismatch

- **Symptom**: `aerospace reload-config` fails with an IPC socket or version error after running `brew upgrade`.
- **Cause**: The background `AeroSpace.app` process is still running the older version while the CLI binary was updated.
- **Fix**: Quit and relaunch AeroSpace (`killall AeroSpace && open -a AeroSpace`).

### Orphaned Copilot Node Processes

- **Symptom**: Stale `node .../copilot/js/language-server.js` processes consuming CPU or memory after terminal windows were closed abruptly.
- **Cause**: Ungraceful window closes bypass Neovim's `VimLeavePre` hook.
- **Fix**: The repository configuration automatically reaps any node process with parent PID 1 on next Neovim start. You can also run `~/scripts/goodnight.sh` to trigger an immediate cleanup.

### Zoxide Prompt Hook Warnings in `.zshrc`

- **Symptom**: Shell startup prints a warning that zoxide was not initialized at the end of `.zshrc`.
- **Cause**: Third-party installers (like Python or IDE tools) frequently append raw export lines to the bottom of `~/.zshrc`.
- **Fix**: Move third-party exports to the top section of `shell/zsh/.zshrc` under `Third-party installer appends`. The final command in `shell/zsh/.zshrc` must remain `welcome-message`.
