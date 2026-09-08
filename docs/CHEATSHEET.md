# Dotfiles Cheatsheet

> _Comprehensive quick-reference guide for daily terminal shortcuts, window management, multiplexing, editor navigation, and system diagnostics._

All commands are synchronized across **Zsh**, **Nushell**, **Bash**, and **Fish** via `shell/shared/` unless explicitly annotated.

---

## 1. Directory Navigation

> _Effortless, keystroke-efficient directory traversal using universal dot shortcuts, fuzzy pickers, and terminal file managers._

| Command | Action          | Behavior & Details                                                                                                                                    |
| :------ | :-------------- | :---------------------------------------------------------------------------------------------------------------------------------------------------- |
| `..`    | `cd ..`         | Traverse up 1 directory level.                                                                                                                        |
| `...`   | `cd ../..`      | Traverse up 2 directory levels.                                                                                                                       |
| `....`  | `cd ../../..`   | Traverse up 3 directory levels.                                                                                                                       |
| `home`  | `cd ~`          | Jump straight to the `$HOME` user directory.                                                                                                          |
| `c`     | `clear`         | Fast terminal screen buffer clear.                                                                                                                    |
| `y`     | Yazi (Sync CWD) | Launches Yazi terminal file manager. Exiting with `q` automatically changes your shell's current working directory to the directory you were viewing. |
| `vf`    | Fuzzy Edit      | Interactive `fzf` file picker with syntax-highlighted `bat` preview; opens the selected file directly in Neovim.                                      |

---

## 2. Project Session Switching (`ts`)

> _Two-letter fuzzy sessionizer discovering projects across `~/projects` and attaching or switching isolated multiplexer sessions._

- **Commands**: `ts` (or `tms`)
- **Keybinding inside tmux**: `<prefix> f` (Ctrl+A f)

### Behavior

- Searches `~/projects` (up to 2 levels deep) and `~/dotfiles` using `fd`.
- Selecting an entry via `fzf`:
    - Sanitizes the directory name into a valid session name (replacing spaces and dots with underscores).
    - Checks if the session exists; if not, creates it detached in the project directory.
    - If running outside a multiplexer, attaches immediately (`exec tmux attach-session`).
    - If running inside tmux, cleanly switches the active client (`tmux switch-client -t <name>`).
    - Passing a directory path directly (`ts ~/projects/backend`) bypasses the interactive picker and attaches immediately.

---

## 3. AeroSpace Tiling Window Manager

> _Modal, keyboard-driven window management dividing workflows across numbered and alphabetical workspaces._

### Focus & Window Movement

| Shortcut      | Action      | Scope / Context                           |
| :------------ | :---------- | :---------------------------------------- |
| `alt-h`       | Focus Left  | Focus adjacent window to the left         |
| `alt-j`       | Focus Down  | Focus adjacent window below               |
| `alt-k`       | Focus Up    | Focus adjacent window above               |
| `alt-l`       | Focus Right | Focus adjacent window to the right        |
| `alt-shift-h` | Move Left   | Swap active window with pane to the left  |
| `alt-shift-j` | Move Down   | Swap active window with pane below        |
| `alt-shift-k` | Move Up     | Swap active window with pane above        |
| `alt-shift-l` | Move Right  | Swap active window with pane to the right |

### Layout & Sizing

| Shortcut      | Action           | Scope / Context                                       |
| :------------ | :--------------- | :---------------------------------------------------- |
| `alt-/`       | Toggle Tiles     | Toggle horizontal and vertical tiling layouts         |
| `alt-,`       | Toggle Accordion | Toggle accordion horizontal and vertical layouts      |
| `alt-space`   | Toggle Float     | Switch active window between floating and tiling mode |
| `alt-shift-f` | Fullscreen       | Toggle fullscreen mode for the active window          |
| `alt-minus`   | Resize Smaller   | Decrease active window dimensions by 50px             |
| `alt-equal`   | Resize Larger    | Increase active window dimensions by 50px             |

### Workspace Navigation

| Shortcut             | Action            | Scope / Context                                                 |
| :------------------- | :---------------- | :-------------------------------------------------------------- |
| `alt-1` .. `alt-9`   | Switch Workspace  | Jump to numbered workspace 1 through 9                          |
| `alt-a` .. `alt-z`   | Switch Workspace  | Jump to alphabetical workspace (e.g. `alt-m`, `alt-d`, `alt-o`) |
| `alt-tab`            | Back & Forth      | Toggle between the current and previous workspace               |
| `alt-shift-tab`      | Move Workspace    | Move current workspace to next monitor                          |
| `alt-shift-1` .. `9` | Move to Workspace | Send focused window to numbered workspace                       |
| `alt-shift-a` .. `z` | Move to Workspace | Send focused window to alphabetical workspace                   |

### Application Shortcuts

| Shortcut          | Target Application | Command Executed                                 |
| :---------------- | :----------------- | :----------------------------------------------- |
| `alt-b`           | Firefox            | `open -a "Firefox"`                              |
| `alt-c`           | Calculator         | `open -a "Calculator"` (auto-floated)            |
| `alt-f`           | Finder             | `open -a "Finder"` (auto-floated)                |
| `alt-g` / `alt-t` | Ghostty            | `open -a "Ghostty"`                              |
| `alt-w`           | WhatsApp           | `open -a "WhatsApp"`                             |
| `alt-shift-0`     | Close Window       | Closes focused window (quits app if last window) |

---

## 4. Terminal Multiplexing (Zellij & Tmux)

> _Persistent workspace managers for multi-pane terminal workflows and detached session persistence._

### Zellij (Primary Multiplexer)

| Keybinding              | Mode / Action   | Behavior                                                         |
| :---------------------- | :-------------- | :--------------------------------------------------------------- |
| `Ctrl-a`                | Pane Mode       | Enter pane management mode                                       |
| &nbsp;&nbsp;↳ `n`       | New Pane        | Split pane automatically                                         |
| &nbsp;&nbsp;↳ `d`       | New Pane Down   | Split active pane vertically (below)                             |
| &nbsp;&nbsp;↳ `x`       | Close Pane      | Terminate the active pane                                        |
| &nbsp;&nbsp;↳ `z`       | Zoom Pane       | Toggle active pane fullscreen                                    |
| &nbsp;&nbsp;↳ `w`       | Float Pane      | Toggle floating pane overlay                                     |
| &nbsp;&nbsp;↳ `r`       | Rename Pane     | Input new name for focused pane                                  |
| `Ctrl-t`                | Tab Mode        | Enter tab management mode                                        |
| &nbsp;&nbsp;↳ `n`       | New Tab         | Create a new tab                                                 |
| &nbsp;&nbsp;↳ `x`       | Close Tab       | Close active tab                                                 |
| &nbsp;&nbsp;↳ `h` / `l` | Previous / Next | Navigate between tabs                                            |
| &nbsp;&nbsp;↳ `r`       | Rename Tab      | Rename active tab                                                |
| `Ctrl-n`                | Resize Mode     | Resize active pane using `h`, `j`, `k`, `l`, `+`, `-`            |
| `Ctrl-s`                | Search Mode     | Scrollback search and pattern matching                           |
| `Ctrl-g`                | Locked Mode     | Lock Zellij keybindings to pass all keys to nested terminal apps |

### Tmux (Fallback Multiplexer)

- **Prefix Key**: `Ctrl-a` (rebound from `Ctrl-b`)

| Keybinding         | Action           | Behavior                                    |
| :----------------- | :--------------- | :------------------------------------------ |
| `<prefix> c`       | New Window       | Create a new tmux window                    |
| `<prefix> \|`      | Split Horizontal | Split pane side-by-side                     |
| `<prefix> -`       | Split Vertical   | Split pane stacked                          |
| `<prefix> h/j/k/l` | Select Pane      | Navigate between panes in Vim directions    |
| `<prefix> z`       | Zoom Pane        | Toggle pane zoom (fullscreen within window) |
| `<prefix> f`       | Sessionizer      | Launch `tmux-sessionizer` project picker    |
| `<prefix> d`       | Detach           | Detach client session safely                |
| `<prefix> x`       | Kill Pane        | Terminate active pane                       |

---

## 5. Modern CLI Replacements & Utilities

> _High-performance command-line tools replacing legacy POSIX utilities with icons, syntax highlighting, and Git indicators._

| Command | Native Tool              | Details                                                                                                                       |
| :------ | :----------------------- | :---------------------------------------------------------------------------------------------------------------------------- |
| `ls`    | `eza --icons`            | Modern file listing with Nerd Font icons                                                                                      |
| `ll`    | `eza -lah --icons --git` | Detailed file listing showing permissions, human sizes, and Git status                                                        |
| `la`    | `eza -A --icons`         | List all files including hidden dotfiles                                                                                      |
| `cat`   | `bat`                    | File display with syntax highlighting, line numbers, and Git modification markers                                             |
| `help`  | `tldr`                   | Practical, community-driven example sheets instead of dense man pages                                                         |
| `anim`  | `ani-cli`                | Terminal anime streaming launcher                                                                                             |
| `C`     | Global Clipboard Pipe    | Appending `C` to any command (e.g. `cat file.json C`) tees output to screen and copies directly to macOS clipboard (`pbcopy`) |

---

## 6. Smart File Opener (`open`)

> _Context-aware shell opener routing files to dedicated native applications by extension with native macOS flag passthrough._

- **Command**: `open <target>`

### Routing Rules

- **macOS Flag Passthrough**: Any flag (`open -a AppName`, `open -R /path`, `open -h`) passes directly to `/usr/bin/open`.
- **Code & Text**: `.py`, `.ts`, `.lua`, `.rs`, `.json`, `.md`, `.toml`, `.yaml`, `.sh`, `.zsh` → opens in Neovim (`nvim`).
- **PDF Documents**: `.pdf` → opens in Sioyek in a new window.
- **Media Files**: `.mp4`, `.mkv`, `.mp3`, `.wav`, `.mov` → opens in IINA media player.
- **Directories**: Opens target directory in Finder.
- **Fallback**: Any unrecognized extension is passed to default system application via `/usr/bin/open`.

---

## 7. Editor & Code Navigation (Neovim 0.12)

> _Sub-37ms editor workflow backed by Neovim 0.12 native LSP client APIs, on-demand Mason tools, and lazy Copilot._

### General & Buffer Management

| Keybinding   | Action           | Details                                             |
| :----------- | :--------------- | :-------------------------------------------------- |
| `v` / `vim`  | Open Neovim      | Launches `nvim`                                     |
| `nvconfig`   | Config Directory | Opens `~/.config/nvim/` directly                    |
| `mini`       | Minimal Profile  | Launches isolated `NVIM_APPNAME=mini` configuration |
| `<leader>ff` | Find Files       | Interactive file picker via Telescope               |
| `<leader>fw` | Live Grep        | Project-wide string search via ripgrep              |
| `<leader>fb` | Find Buffers     | Switch between open editor buffers                  |
| `<leader>th` | Theme Switcher   | NvChad interactive theme picker                     |
| `<tab>`      | Next Buffer      | Navigate to next open buffer tab                    |
| `<S-tab>`    | Previous Buffer  | Navigate to previous open buffer tab                |
| `<leader>x`  | Close Buffer     | Close active buffer without disrupting window split |

### Neovim 0.12 Native LSP Actions

| Keybinding   | Action              | Details                                                              |
| :----------- | :------------------ | :------------------------------------------------------------------- |
| `gd`         | Go to Definition    | Jump to symbol declaration/definition                                |
| `gr`         | References          | List all references across project in quickfix                       |
| `gi`         | Implementation      | Jump to interface implementation                                     |
| `K`          | Hover Documentation | Show LSP type signature and documentation popup                      |
| `<leader>ra` | Rename Symbol       | Project-wide symbol rename via LSP                                   |
| `<leader>ca` | Code Action         | Open available code actions and quickfixes                           |
| `<leader>fm` | Format Code         | Format current buffer using active LSP formatter (e.g. ruff, lua_ls) |
| `[d`         | Previous Diagnostic | Jump to previous diagnostic warning/error                            |
| `]d`         | Next Diagnostic     | Jump to next diagnostic warning/error                                |

### Native Commenting & AI

| Keybinding    | Action                   | Details                                                     |
| :------------ | :----------------------- | :---------------------------------------------------------- |
| `gcc`         | Toggle Line Comment      | Comment/uncomment current line (native 0.12 comment engine) |
| `gc`          | Toggle Selection Comment | In visual mode, comments/uncomments highlighted block       |
| `<leader>cc`  | CopilotChat              | Toggles Copilot chat split (lazy loaded on demand)          |
| `<leader>cce` | Copilot Explain          | Asks Copilot to explain selected code                       |
| `<leader>ccf` | Copilot Fix              | Asks Copilot to diagnose and fix selected code              |

---

## 8. Git & Version Control

> _Single-character Git aliases covering 95% of daily commit, branch, and inspection workflows._

| Alias | Command      | Details                                                                   |
| :---- | :----------- | :------------------------------------------------------------------------ |
| `g`   | `git`        | Root Git command wrapper                                                  |
| `gs`  | `git status` | Show working directory status                                             |
| `gd`  | `git diff`   | Show unstaged file diffs                                                  |
| `gc`  | `git commit` | Trigger commit editor                                                     |
| `gp`  | `git push`   | Push committed changes to tracking remote                                 |
| `lg`  | `lazygit`    | Terminal UI for visual staging, interactive rebase, and branch inspection |

---

## 9. Guarded Docker Workflows

> _High-speed Docker management shortcuts with fuzzy container execution and guarded cleanup._

| Command  | Action               | Details                                                                                    |
| :------- | :------------------- | :----------------------------------------------------------------------------------------- |
| `dexec`  | Fuzzy Container Exec | Selects a running container via `fzf` and attaches an interactive `sh` or `bash` shell     |
| `dstop`  | Stop All Containers  | Checks for running containers; cleanly terminates them or informs if already idle          |
| `dclean` | Safe Prune           | Prunes stopped containers, dangling images, and build cache without destroying volumes     |
| `dprune` | Hard Reset           | Prompts for confirmation; resets stopped containers, unused networks, and dangling volumes |
| `dstats` | Container Monitor    | Live terminal monitor of memory and CPU utilization per container                          |

---

## 10. Display, Theme & System Diagnostics

> _Coordinated system maintenance, color palette switching, and offline AI assistance._

| Command               | Action             | Details                                                                                |
| :-------------------- | :----------------- | :------------------------------------------------------------------------------------- |
| `theme-switch <name>` | Theme Switcher     | Coordinates color changes across Ghostty, Neovim, Yazi, Zellij, Tmux, Zsh, and Nushell |
| `gray`                | Grayscale Toggle   | Toggles macOS system display grayscale filter for focus                                |
| `dark`                | Dark Mode Toggle   | Toggles macOS system appearance between Light and Dark mode                            |
| `goodnight`           | Sleep Routine      | Runs nightly system hygiene and process reaping                                        |
| `ai`                  | Local Llama / Qwen | Launches local offline 7B coder LLM via `llama-cli` with GPU acceleration              |
| `doctor`              | System Diagnostic  | Runs 28 automated checks verifying symlinks, shell syntax, LSP, and themes             |
| `deploy`              | Link Deployment    | Idempotently synchronizes symlinks from repository manifest into `$HOME`               |
