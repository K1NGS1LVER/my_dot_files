# 🛠️ Custom Development Environment Documentation

Welcome to your personalized terminal-based development environment. This setup is built on top of **NvChad** (Neovim) with customized workflows for efficient coding and note-taking.

## ⚙️ Technical Details

### Core Architecture
- **Editor Engine:** Neovim (v0.10+)
- **Configuration Framework:** [NvChad](https://nvchad.com/) (Lua-based)
- **Shell:** Zsh with Oh-My-Zsh & Autosuggestions
- **Operating System:** macOS

### Key Plugin Clusters
1.  **IDE Features:** `nvim-lspconfig`, `conform.nvim` (formatting), `nvim-cmp` (completion), `nvim-treesitter` (syntax).
2.  **Navigation:** `telescope.nvim` (fuzzy find), `harpoon` (quick file jumping), `vim-tmux-navigator`.
3.  **Note Taking:**
    -   `obsidian.nvim`: Wiki-linking and Zettelkasten workflow.
    -   `bullets.vim`: Automatic bullet list management.
    -   `vim-table-mode`: Instant Markdown table formatting.
    -   `zen-mode.nvim`: Distraction-free writing.
    -   `markdown-preview.nvim`: Live browser preview.

---

## 📥 Installation

Since this is your active environment, these steps are for replication or recovery.

1.  **Prerequisites:**
    ```bash
    brew install neovim ripgrep fd node
    ```

2.  **Clone Configuration:**
    ```bash
    git clone https://github.com/NvChad/starter ~/.config/nvim && nvim
    # (Then apply your custom lua/plugins/init.lua and settings)
    ```

3.  **Install Language Servers:**
    Open Neovim and run:
    ```vim
    :Mason
    ```
    Install servers for your languages (e.g., `pyright`, `tsserver`, `lua-ls`).

---

## 🚀 Usage Guide

### Daily Workflow
1.  **Open Terminal:** Launch your terminal (Alacritty/iTerm2/Kitty).
2.  **Navigate:** Use `z` or `cd` to your project.
3.  **Edit:** Run `nvim .` to open the directory.
4.  **Note Taking:**
    -   Open your notes: `cd ~/notes && nvim index.md`
    -   Link to new ideas using `[[Concept Name]]`.

### Managing Plugins
-   **Update:** Run `:Lazy sync` to update all plugins.
-   **Check Health:** Run `:checkhealth` if something behaves oddly.

---

## ⌨️ Cheatsheet

### 🧭 Navigation
| Command | Action |
| :--- | :--- |
| `<Space>ff` | Find files (Telescope) |
| `<Space>fw` | Find text/grep (Telescope) |
| `<Ctrl> + h/j/k/l` | Navigate between windows |
| `<Space>1` - `<Space>4` | Jump to Harpoon file 1-4 |
| `<Space>a` | Add file to Harpoon |
| `<Space>h` | Show Harpoon menu |

### 📝 Note Taking
| Command | Action |
| :--- | :--- |
| `<Space>mp` | Toggle Markdown Live Preview |
| `<Space>z` | Toggle Zen Mode (Focus) |
| `<Space>tm` | Toggle Table Mode (Auto-format tables) |
| `[[` | Trigger link completion (Obsidian) |
| `-` / `*` + `Enter` | Auto-continue list (Bullets) |

### 💻 General Editing
| Command | Action |
| :--- | :--- |
| `<Space>x` | Close buffer |
| `<Space>qq` | Quit Neovim (Instant) |
| `<Space>s` | Save file (custom mapping if set) |

### ⚡ LSP (Code Intelligence)
| Command | Action |
| :--- | :--- |
| `gd` | Go to Definition |
| `K` | Hover Documentation |
| `<Space>ra` | Rename Variable |
| `<Space>ca` | Code Action |
| `<Space>d` | Show Diagnostics (Hover) |

---

## 🛠️ Maintenance & Audits
For a detailed list of resolved keybinding conflicts and system optimizations, see [CONFLICT_AUDIT.md](./CONFLICT_AUDIT.md).

For guide on Media Playback (MPV/IINA) and Chat, see [MEDIA_GUIDE.md](./MEDIA_GUIDE.md).
