# Ultimate Terminal & Workflow Guide (2025 Edition)

This document details the configuration for the "Power User" setup involving Zellij, Neovim (NvChad), and a unified multi-shell environment (Zsh, Bash, Fish).

## 1. The Core: Zellij (Tmux Replacement)

We have replaced Tmux with **Zellij**, configured to mimic Tmux's best features while adding modern UI and speed.

### **Key Features**
*   **Status Bar:** Custom `zjstatus` plugin providing a Tmux-like bar with Catppuccin Macchiato colors.
*   **Navigation:** Vim-style navigation (`Ctrl + h/j/k/l`) works seamlessly between Zellij panes and Neovim windows.
*   **Auto-Naming:** Tabs automatically rename to the running command (e.g., `nvim`, `git`) and revert to the directory name when done.

### **Keybindings (Tmux-Style Leader: `Ctrl + a`)**

| Action | Shortcut | Alternate (Zellij Mode) |
| :--- | :--- | :--- |
| **New Tab** | `Ctrl + a` then `c` | `Ctrl + t` then `n` |
| **Rename Tab** | `Ctrl + a` then `,` | `Ctrl + t` then `r` |
| **Next Tab** | `Shift + Right` | `Alt + n` |
| **Prev Tab** | `Shift + Left` | `Alt + p` |
| **Detach** | `Ctrl + a` then `d` | `Ctrl + o` then `d` |
| **Zoom Pane** | `Ctrl + a` then `z` | `Ctrl + p` then `f` |
| **Close Tab** | `Ctrl + w` | `Ctrl + t` then `x` |
| **Move Focus** | `Ctrl + h/j/k/l` | (Same) |

### **Aliases**
*   **`ntmux`**: Launches Zellij (New Tmux).
*   **`z`**: Launches `zoxide` (Smart CD).

---

## 2. The Editor: Neovim (NvChad + AI)

Your Neovim setup is now an AI-powered IDE.

### **AI Assistant (`avante.nvim`)**
Acts like "Cursor" or "Copilot" but runs **locally** on your machine using Ollama.
*   **Model:** `deepseek-coder:6.7b`
*   **Usage:**
    *   **Ask AI:** `<leader>aa` (Ask about code).
    *   **Edit Code:** `<leader>ae` (Highlight code -> Ask AI to refactor).
    *   **Refresh:** `<leader>ar`.

### **Multiplexer Integration**
Replaced `vim-tmux-navigator` with a smart hybrid config.
*   If in **Tmux**: Uses standard Tmux commands.
*   If in **Zellij**: Detects environment and sends `zellij action move-focus`.
*   **Result:** `Ctrl + h/j/k/l` moves seamlessly across everything.

---

## 3. The Shells (Unified Experience)

You can now use **Zsh**, **Bash**, or **Fish** interchangeably. They share history and key tools.

### **Shared Tools**
*   **Zoxide:** Smarter `cd`. Usage: `z <folder_name>`.
*   **Atuin:** Syncs shell history. Usage: `Ctrl + r` (or Up arrow in Fish).
*   **Eza:** Modern `ls`. Aliased to `ls` and `ll`.
*   **The Fuck:** Auto-correction. Type `fuck` after a mistake.
*   **Todo CLI:** Custom Go binary (`todo-go`).

### **Zsh Exclusives**
*   **fzf-tab:** "God-mode" tab completion.
    *   Tab-completing `cd`? You see a preview of the folder contents.
    *   Tab-completing `cat`? You see the file contents.

### **The "Todo" Workflow**
A custom tool written in **Go** (`~/dotfiles/scripts/todo.go`) interacts with Todoist API.
*   **Command:** `todo`
*   **Action:** Fetches "Today", "Overdue", "Inbox" tasks.
*   **UI:** Filters with `fzf` (hides IDs, shows text).
*   **Complete:** Select a task and press Enter to close it.

---

## 4. Maintenance & Files

*   **Dotfiles Repo:** `~/dotfiles`
*   **Zellij Config:** `~/dotfiles/.config/zellij/config.kdl`
*   **Layouts:** `~/dotfiles/.config/zellij/layouts/`
*   **Scripts:** `~/dotfiles/scripts/`

### **How to Update**
All configs are symlinked. Edit them in `~/dotfiles` and push to Git.
```bash
cd ~/dotfiles
git add .
git commit -m "update config"
git push
```
