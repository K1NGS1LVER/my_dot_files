# 🖥️ Mac System Configuration & Documentation

This document serves as the **master reference** for the development environment configured on this machine. It covers the shell, terminal tools, Neovim (NvChad) setup, and automation scripts.

---

## 🚀 **Shell Environment (Zsh)**

The shell is powered by **Zsh** with **Oh My Zsh** and the **Powerlevel10k** theme.

### **Core Components**

- **Framework**: [Oh My Zsh](https://ohmyz.sh/)
- **Theme**: [Powerlevel10k](https://github.com/romkatv/powerlevel10k) (Instant prompt, Git status, execution time).
- **Font**: Nerd Fonts (required for icons).

### **Active Plugins**

| Plugin                        | Description                         | Usage                                     |
| :---------------------------- | :---------------------------------- | :---------------------------------------- |
| **`zsh-autosuggestions`**     | Suggests commands based on history. | Type prefix → `Right Arrow` to accept.    |
| **`zsh-syntax-highlighting`** | Colorizes commands in real-time.    | Green = Valid, Red = Invalid.             |
| **`git`**                     | Adds git aliases and functions.     | `gst`, `ga`, `gcmsg`, etc.                |
| **`fzf`**                     | Fuzzy Finder integration.           | `Ctrl + R` (History), `** + Tab` (Files). |

### **Modern CLI Replacements**

| Alias            | Tool          | Replaces | Why?                                                                    |
| :--------------- | :------------ | :------- | :---------------------------------------------------------------------- |
| `ls`, `ll`, `la` | **`eza`**     | `ls`     | Colors, icons, git status, tree view.                                   |
| `cat`            | **`bat`**     | `cat`    | Syntax highlighting, line numbers, git diff integration.                |
| `z`              | **`zoxide`**  | `cd`     | Remembers frequently visited dirs. `z gemini` jumps to `.../GeminiCLI`. |
| `help`           | **`tldr`**    | `man`    | Simplified, community-driven examples. `help tar`.                      |
| `lg`             | **`lazygit`** | `git`    | Terminal UI for complex git operations.                                 |
| `todo`           | **`todoist`** | `todoist`| Interactive task manager. Filters Today/Inbox/Recurring + FZF selection.|

---

## ⌨️ **Neovim (NvChad) Configuration**

The editor is **Neovim (v0.10+)** running the **NvChad** distribution, customized for full-stack development.

### **Key Mappings**

- **Leader Key**: `SPACE`

#### **General**

- `jk` (in insert mode) → Exit to Normal mode.
- `<C-s>` / `<leader>w` → Save file.
- `<leader>q` → Quit.
- `<Esc>` → Clear search highlights.

#### **Navigation**

- `<C-h/j/k/l>` → Move between windows.
- `<S-h/l>` → Previous/Next buffer (tab).
- `<leader>bd` → Close current buffer.
- `gd` / `gr` → Go to Definition / References.

#### **Git & Terminal**

- `<leader>gg` → Open **LazyGit** window.
- `<C-\>` → Toggle floating terminal.
- `<leader>tf` / `<leader>tv` → Toggle Float / Vertical terminal.

#### **Debugging (DAP)**

- `<leader>db` → Toggle Breakpoint.
- `<leader>dc` → Continue.
- `<leader>ui` → Toggle Debug UI.

### **Installed Plugins**

- **LSP/Linting**: `nvim-lspconfig`, `conform.nvim` (Formatting), `trouble.nvim` (Diagnostics).
- **Navigation**: `telescope.nvim`, `telescope-fzf-native` (Fast search).
- **Coding**:
  - `nvim-cmp` (Autocompletion).
  - `Comment.nvim` (`gcc` to comment line).
  - `nvim-surround` (`ysiw"` to surround word with quotes).
  - `todo-comments` (Highlights TODO/FIXME).
- **UI/UX**:
  - `alpha-nvim`: Custom dashboard on startup (Header, buttons for new file/find file).
  - `vim-tmux-navigator`: Seamless navigation between Neovim splits and Tmux panes.
- **Sessions**: `persistence.nvim` (Restore last session with `<leader>qs`).

### **Language Servers (LSP)**

Configured in `lua/configs/lspconfig.lua` for:
`html`, `css`, `typescript/javascript (ts_ls)`, `eslint`, `json`, `yaml`, `bash`, `docker`, `python`, `rust`, `go`, `lua`.

---

## ⚡ **Raycast & Automation**

Raycast acts as the command center, bridging the gap between GUI and CLI scripts.

### **The "Bridge" Architecture**

1.  **Source Scripts**: Located in `~/scripts/`.
2.  **Wrappers**: Located in `~/Applications/RaycastWrappers/`.
3.  **Sync Tool**: `import_scripts_to_raycast.sh` generates the wrappers.

### **How to Add a New Script**

1.  Create a script in `~/scripts/myscript.sh`.
2.  Run **"Sync User Scripts"** in Raycast.
3.  Search **"Myscript"** in Raycast to run it (opens in iTerm2).

### **Current Automation Tools**

- **Gemini CLI**: Direct interface to AI assistant.
- **System Cleaners**: `docker_cleaner`, `git_cleaner`, `node_cleaner`, `log_cleaner`.
- **Utilities**: `large_file_finder`, `duplicate_cleaner`.

---

## 📂 **Directory Map**

| Path                       | Purpose                                |
| :------------------------- | :------------------------------------- |
| `~/scripts`                | Raw shell scripts storage.             |
| `~/Applications/GeminiCLI` | Configuration for Raycast integration. |
| `~/.config/nvim`           | Neovim configuration (Lua).            |
| `~/.zshrc`                 | Shell configuration.                   |
| `~/readme`                 | Documentation storage.                 |

---

## 💡 **Pro Tips**

- **Fuzzy History**: Forgot a command? Press `Ctrl+R` and type a keyword.
- **Smart Jump**: Want to go to a deep folder you visited yesterday? Type `z foldername`.
- **Code Review**: In Neovim, press `<leader>gg` to manage git changes visually.
- **Quick Docs**: Don't know how to use `tar`? Type `help tar` (alias for `tldr`).

---

## ⌨️ **Terminal Keybindings (Emacs/Readline Mode)**

These shortcuts allow for efficient text manipulation on the command line, similar to standard text editors.

### **Navigation**
| Shortcut | Action |
| :--- | :--- |
| `Ctrl + A` | Jump to **start** of line. |
| `Ctrl + E` | Jump to **end** of line. |
| `Option + Left` | Move backward one word. |
| `Option + Right` | Move forward one word. |

### **Cutting & Deleting**
| Shortcut | Action |
| :--- | :--- |
| `Ctrl + W` | Cut the word **before** the cursor. |
| `Option + D` | Cut the word **after** the cursor. |
| `Option + Backspace` | Delete the word **before** the cursor. |
| `Ctrl + U` | Cut from cursor to **start** of line. |
| `Ctrl + K` | Cut from cursor to **end** of line. |

### **Pasting & Altering**
| Shortcut | Action |
| :--- | :--- |
| `Ctrl + Y` | **Paste** (Yank) the last cut text. |
| `Option + T` | **Swap** current word with previous word. |
| `Ctrl + T` | **Swap** current character with previous character. |

> **Note**: For `Option` keys to work in iTerm2, ensure `Left Option` is set to `Esc+` in Profiles > Keys.

---

## 🛠️ **Additional Configuration**

### **Bat (Better Cat) Theme**
*   **Active Theme**: `Catppuccin Mocha`
*   **Configuration**:
    *   Themes manually downloaded to `$(bat --config-dir)/themes`.
    *   Cache rebuilt via `bat cache --build`.
    *   Theme set in `~/.zshrc` via `export BAT_THEME="Catppuccin Macchiato"`.

### **Zed Editor** (`~/.config/zed`)
A high-performance Rust-based code editor.
*   **Theme**: Tokyo Night Storm (Dark) / One Dark (Light).
*   **Keymap**: VSCode style.
*   **Formatting**: Prettier configured for JS/TS/HTML/JSON.
*   **Java**: Pointing to Temurin 24 JDK (`/Library/Java/JavaVirtualMachines/temurin-24.jdk`).
*   **UI**: Right-side dock, status bar hidden, autosave on focus change.

### **GitHub CLI (`gh`)**
*   **Config**: `~/.config/gh/config.yml`
*   **Alias**: `gh co` → `gh pr checkout` (Quickly check out PRs).

### **Goose AI** (`~/.config/goose`)
*   **Model**: `gemini-2.5-pro` via `gemini-cli`.
*   **Enabled Extensions**: Developer tools.

### **Git Global Config** (`~/.gitconfig`)
*   **User**: Daniel paul
*   **LFS**: Git Large File Storage is initialized.

---

## 💡 **Management Tips**

### **Managing Plugins**
*   **Disable Autosuggestions**: Open `~/.zshrc`, comment out `zsh-autosuggestions`, and run `source ~/.zshrc`.
*   **Enable Autosuggestions**: Open `~/.zshrc`, uncomment `zsh-autosuggestions`, and run `source ~/.zshrc`.