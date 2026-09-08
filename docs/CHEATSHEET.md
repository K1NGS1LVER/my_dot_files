# Dotfiles Cheatsheet

> **One-Liner**: *High-frequency reference card for daily terminal shortcuts, project switching, editor navigation, and system diagnostics.*

All commands are synchronized across **Zsh**, **Nushell**, **Bash**, and **Fish** via `shell/shared/` unless explicitly annotated.

---

## 1. Directory Navigation

> **One-Liner**: *Effortless, keystroke-efficient directory hopping using universal relative dot shortcuts and home-row ergonomics.*

| Command | Action | In-Depth Behavior |
| :--- | :--- | :--- |
| `..` | `cd ..` | Traverse up 1 directory level. |
| `...` | `cd ../..` | Traverse up 2 directory levels. |
| `....` | `cd ../../..` | Traverse up 3 directory levels. |
| `home` | `cd ~` | Jump straight to `$HOME` directory. |
| `c` | `clear` | Fast terminal buffer clear. |
| `y` | Yazi (Sync CWD) | Opens Yazi file manager. Upon quitting with `q`, your shell automatically `cd`s to the folder you were viewing. |
| `vf` | Fuzzy Edit | Interactive `fzf` file picker with syntax-highlighted `bat` preview; opens selected file directly in Neovim. |

---

## 2. Project Switching (`ts`)

> **One-Liner**: *2-letter fuzzy sessionizer that discovers projects and attaches or switches isolated tmux sessions on the fly.*

- **Command**: `ts` (or `tms`)
- **Keybinding inside tmux**: `<prefix> f` (Ctrl+A f)
- **In-Depth**: Searches `~/projects` (up to 2 levels deep) and `~/dotfiles` using `fd`. Selecting an entry via `fzf`:
  - Sanitizes the directory name into a valid tmux session name (replacing spaces and dots with underscores).
  - Checks if the session exists; if not, creates it detached in the project directory.
  - If running outside tmux, attaches to it (`exec tmux attach-session`).
  - If running inside tmux, cleanly switches the active client (`tmux switch-client -t <name>`).
  - Directly passing a path (`ts ~/projects/my-app`) skips the picker and attaches immediately.

---

## 3. Editor & Notes

> **One-Liner**: *Lightning-fast 35ms Neovim 0.12 workflow backed by native LSP, insert-triggered Copilot, and quick vault access.*

| Command | Action | In-Depth Behavior |
| :--- | :--- | :--- |
| `v` | `nvim` | 1-letter ultra-fast invocation for Neovim. |
| `vim` | `nvim` | Standard muscle-memory fallback. |
| `nvconfig` | `nvim ~/.config/nvim/` | Direct jump into your Neovim configuration root. |
| `notes` | `clin --vault ~/notes` | Quick-search and write inside your personal Obsidian notes vault. |
| `mini` | `NVIM_APPNAME=mini nvim` | Vanilla Neovim profile (no heavy plugins, used for pure editing and diagnostics). |

### Essential Neovim Keybindings
- `<leader>e` → Open Yazi file tree inside Neovim (`<leader>cw` opens cwd, `<leader>y` toggles).
- `<leader>gg` → Open LazyGit TUI overlay.
- `gc` / `gcc` → Native Neovim 0.10+ commenting on visual selection or current line.
- `<leader>cc` → Toggle GitHub Copilot Chat (lazy-loaded on demand).
- `gd` / `gr` / `K` → Native LSP Go to Definition, References, and Hover Documentation.
- `<leader>th` → Open theme selector inside Neovim.

---

## 4. Modern File Listing & CLI Replacements

> **One-Liner**: *Modern Rust-powered CLI utilities replacing legacy POSIX tools with icons, syntax highlighting, and Git indicators.*

| Command | Native Tool | In-Depth Behavior |
| :--- | :--- | :--- |
| `ls` | `eza --icons` | Directory listing with filetype icons and color-coded file extensions. |
| `ll` | `eza -lah --icons --git` | Full long-format listing displaying exact permissions, size, and inline Git status flags. |
| `la` | `eza -A --icons` | List almost all files (including dotfiles). |
| `cat <file>` | `bat` | File viewer with automatic syntax highlighting, line numbers, and Git gutter modifications. |
| `help <cmd>` | `tldr` | Practical, community-driven cheatsheets and usage examples instead of dense manpages. |
| `C` | `pbcopy` | Pipe directly to macOS clipboard (e.g. `pwd \| C` or `cat script.py \| C`). |

---

## 5. Smart File Opener (`open`)

> **One-Liner**: *Context-aware shell opener routing files to dedicated native apps by file extension with full macOS flag support.*

- **Command**: `open <target>`
- **In-Depth Routing Table**:
  - Code/Configs (`.py`, `.ts`, `.lua`, `.rs`, `.json`, `.md`, `.toml`, `.yaml`, `.sh`) → Opens in **Neovim**.
  - Documents (`.pdf`) → Opens in **Sioyek** PDF reader (new window).
  - Media (`.mp4`, `.mkv`, `.avi`, `.mp3`, `.wav`, `.flac`) → Opens in **IINA** media player.
  - Web & Books (`.epub`, `.html`) → Opens in Apple Books / Browser.
  - Flag Passthrough (`open -a AppName`, `open -R file`, `open -h`) → Passes straight to `/usr/bin/open "$@"`.

---

## 6. Git Shortcuts

> **One-Liner**: *Single-character Git aliases covering 95% of daily commit, branch, and inspection workflows.*

| Alias | Command | In-Depth Behavior |
| :--- | :--- | :--- |
| `lg` | `lazygit` | Terminal TUI for visual staging, interactive rebasing, and merge resolution. |
| `g` | `git` | Base git command. |
| `gs` | `git status` | Clean status overview of modified, staged, and untracked files. |
| `gd` | `git diff` | Diff of unstaged working tree changes. |
| `gc` | `git commit` | Commit staged changes. |
| `gp` | `git push` | Push committed changes to tracking remote. |

---

## 7. Docker Containers & Images

> **One-Liner**: *High-speed Docker management shortcuts with fuzzy container execution and guarded cleanup.*

| Command | Action | In-Depth Behavior |
| :--- | :--- | :--- |
| `dps` | Docker Process List | Tabular overview of running containers (`Name`, `Status`, `Ports`). |
| `dimg` | Docker Images | Formatted list of local images (`Repository`, `Tag`, `Size`). |
| `dsh` | Interactive Shell | Fuzzy-selects a running container via `fzf` and drops you into an interactive `/bin/sh` session. |
| `dstop` | Safe Container Stop | Stops all running containers; safely guards against errors if no containers are running. |
| `dclean` | System Prune | Prunes stopped containers, dangling build caches, and unused images (`docker system prune -af`). |

---

## 8. Themes & System Utilities

> **One-Liner**: *Coordinated system maintenance, color palette switching, and offline AI assistance.*

| Command | Action | In-Depth Behavior |
| :--- | :--- | :--- |
| `theme-switch` | Theme Picker | Launches an interactive `fzf` selector to switch themes simultaneously across Ghostty, Kitty, Neovim, Yazi, Tmux, Zsh, and Nushell. |
| `theme-switch <name>`| Direct Switch | Switches directly to `<name>` (e.g. `theme-switch monokai-pro`). |
| `dark` | Toggle Dark Mode | Toggles macOS system appearance between light and dark. |
| `gray` | Toggle Grayscale | Toggles macOS screen filter to high-focus black-and-white. |
| `ai` | Offline LLM | Runs `llama-cli` with Qwen 2.5 Coder 7B (GGUF Q4_K_M) utilizing Apple Silicon Metal GPU offload (99 layers). |
| `anim` | Anime Streaming | Launches `ani-cli` terminal client for searching and streaming anime episodes. |
| `timer <sec>` | Countdown Timer | Visual terminal countdown; triggers a native macOS banner alert upon completion. |
| `goodnight` | Nightly Maintenance | Reaps zombie language server processes, cleans caches, and runs machine maintenance. |

---

## 9. Diagnostics & Repository Deployment

> **One-Liner**: *Self-healing deployment and single-pass automated validation for the entire environment.*

| Command | Script Path | In-Depth Behavior |
| :--- | :--- | :--- |
| `doctor` | `scripts/doctor` | Comprehensive 28-point automated diagnostic suite checking symlink resolution, shell syntax, Neovim checkhealth, active Mason LSP servers, AeroSpace dry-run, and theme registry agreement. |
| `deploy` | `scripts/deploy` | Idempotently materializes all 37 symlinks from `scripts/lib/manifest.sh`, backs up replaced files to `~/.dotfiles-backup/`, and cleans obsolete links. |
| `reload` | Shell Builtin | Re-sources your active shell configuration (`source ~/.zshrc` in Zsh; `exec nu` in Nushell; `source ~/.config/fish/config.fish` in Fish). |
| `update-brew`| `scripts/update-brew` | Runs `brew update`, `brew upgrade`, and purges orphaned ghost GUI casks. |
