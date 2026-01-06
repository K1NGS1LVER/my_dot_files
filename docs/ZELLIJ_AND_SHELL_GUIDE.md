# Ultimate Terminal & Workflow Guide (2025 Edition)

This document details the configuration for the "Power User" setup involving Zellij, Neovim (NvChad), and a unified multi-shell environment (Zsh, Bash, Fish).

## 1. The Core: Zellij (Tmux Replacement)

We have replaced Tmux with **Zellij**, configured to mimic Tmux's best features while adding modern UI and speed.

### **UI & Aesthetics**
*   **Status Bar:** Custom `zjstatus` plugin providing a **clean, minimal** aesthetic.
*   **Theme:** Catppuccin Macchiato with a custom **Active Purple (`#6B5C8F`)** highlight.
*   **Auto-Naming:** Tabs automatically rename to the running command (e.g., `nvim`, `git`) and revert to the directory name when done.
*   **Smart Launch:** `ntmux` launches a session named "dan" 90% of the time, and a random funny name 10% of the time.

### **Keybindings (Tmux-Style Leader: `Ctrl + a`)**

| Action | Shortcut | Alternate (Zellij Mode) |
| :--- | :--- | :--- |
| **New Tab** | `Ctrl + a` then `c` | `Ctrl + t` then `n` |
| **Rename Tab** | `Ctrl + a` then `,` | `Ctrl + t` then `r` |
| **Jump to Tab 1-9** | `Ctrl + a` then `1..9` | `Alt + 1..9` (if terminal configured) |
| **Next Tab** | `Shift + Right` | `Alt + n` |
| **Prev Tab** | `Shift + Left` | `Alt + p` |
| **Detach** | `Ctrl + a` then `d` | `Ctrl + o` then `d` |
| **Zoom Pane** | `Ctrl + a` then `z` | `Ctrl + p` then `f` |
| **Close Tab** | `Ctrl + w` | `Ctrl + t` then `x` |
| **Move Focus** | `Ctrl + h/j/k/l` | (Same) |

**Important Conflict Fixes:**
*   **`Ctrl + s`**: Unbound in Zellij so it passes to Neovim (Submit AI Prompt).
*   **`Ctrl + n`**: Unbound in Zellij so it passes to `nchat` (Next Chat).

### **Aliases**
*   **`ntmux`**: Launches Zellij (Smart Session Manager).
*   **`z`**: Launches `zoxide` (Smart CD).

---

## 2. The Editor: Neovim (NvChad + AI)

Your Neovim setup is now an AI-powered IDE.

### **AI Assistant (`avante.nvim`)**
Acts like "Cursor" or "Copilot" but runs **locally** on your machine using Ollama.
*   **Models:**
    *   **Primary:** `llama3` (8B) - Smart, General Purpose.
    *   **Secondary:** `deepseek-coder:1.3b` - Fast, Code Specific.
*   **Usage:**
    *   **Ask AI:** `<leader>aa` (Ask about code).
    *   **Edit Code:** `<leader>ae` (Highlight code -> Ask AI to refactor).
    *   **Toggle Model:** `<leader>am` (Switch between Llama3 and DeepSeek).
    *   **Submit:** `Ctrl + s` (in Chat window).

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
*   **fzf-tab:** "God-mode" tab completion with file previews.

### **Yazi (File Manager)**
*   **Ebooks:** `.epub` and `.pdf` files automatically open in **Apple Books**.
*   **Fallback:** Unknown files open in the system default app.

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