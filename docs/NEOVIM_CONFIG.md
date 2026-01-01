# ⚡️ Custom Neovim Configuration (NvChad Extended)

This configuration is built on top of **NvChad v2.5** but heavily modified for a streamlined, logic-driven workflow. It emphasizes keyboard-centric navigation (Harpoon), Markdown productivity, and native terminal integration.

**Maintained by:** Dan  
**Base:** [NvChad](https://nvchad.com)  
**Package Manager:** lazy.nvim

---

## 🚀 Key Features

### 1. 🔱 Harpoon v2 Integration (File Navigation)
Replaces traditional bufferline navigation with ThePrimeagen's Harpoon workflow.  
*Keybindings are optimized to use Leader keys to avoid window/system conflicts.*

| Key | Action | Context |
| :--- | :--- | :--- |
| `<leader>a` | **Add** current file to Harpoon list | Global |
| `<C-e>` | **Toggle** Harpoon quick menu | Global |
| `<leader>1` | Navigate to File **1** | Global |
| `<leader>2` | Navigate to File **2** | Global |
| `<leader>3` | Navigate to File **3** | Global |
| `<leader>4` | Navigate to File **4** | Global |
| `<C-S-P>` | Navigate **Previous** in list | Global |
| `<C-S-N>` | Navigate **Next** in list | Global |

### 2. 📝 Advanced Markdown Suite
A complete IDE experience for note-taking and documentation.

*   **Rendering:** `render-markdown.nvim` (In-editor WYSIWYG-like experience).
*   **Logic:** `bullets.vim` (Smart list renumbering and auto-indentation).
*   **Linking:** `obsidian.nvim` (Wiki-links `[[Link]]` and workspace management).
*   **Tables:** `vim-table-mode` (Auto-formatting tables).

| Key | Action |
| :--- | :--- |
| `<leader>ck` | Toggle Checkbox (`[ ]` -> `[x]`) |
| `<leader>rm` | Toggle Render Markdown |
| `<leader>tm` | Toggle Table Mode |
| `<leader>fo` | Find Obsidian Note (Quick Switch) |

### 3. 🖥️ Native Terminal Workflow
Replaces `toggleterm.nvim` with NvChad's lightweight native terminal, using familiar bindings.

| Key | Action | Type |
| :--- | :--- | :--- |
| `<C-t>` | Toggle **Floating** Terminal | Float |
| `<leader>tf` | Toggle **Floating** Terminal | Float |
| `<leader>h` | Toggle **Horizontal** Split Terminal | Split |
| `<leader>tv` | Toggle **Vertical** Split Terminal | Split |
| `<A-v>` | Toggle Vertical (NvChad Default) | Split |
| `<A-h>` | Toggle Horizontal (NvChad Default) | Split |

### 4. 🧠 LSP & Development
Full LSP support via `nvim-lspconfig` and `mason.nvim`.
*   **Languages Enabled:** Lua, Python (Pyright), TypeScript/JS, HTML, CSS, Bash, Go, Rust, Docker, JSON, YAML.
*   **Formatting:** Auto-formatting on save via `conform.nvim` (Prettier, StyLua, Black, Rustfmt).
*   **Diagnostics:** Enhanced UI with icons and borders.

---

## 📂 Project Structure

```text
~/.config/nvim/
├── lua/
│   ├── configs/       # Plugin-specific configurations
│   │   ├── lspconfig.lua   # LSP Server setups
│   │   ├── lazy.lua        # Lazy.nvim settings
│   │   └── ...
│   ├── plugins/       # Plugin definitions (lazy.nvim specs)
│   │   └── init.lua        # Main plugin list
│   ├── autocmds.lua   # Auto-commands (Filetypes, UI fixes)
│   ├── mappings.lua   # Global Keybindings
│   ├── options.lua    # Vim Options (Relative numbers, etc.)
│   └── chadrc.lua     # NvChad Theme/UI Overrides
└── init.lua           # Entry point
```

## 🛠️ Installation & Requirements

### Requirements
*   **Neovim:** >= 0.9.0
*   **Nerd Font:** (JetBrainsMono Nerd Font recommended)
*   **External Tools:**
    *   `ripgrep` (for Telescope)
    *   `gcc` (for Treesitter)
    *   `node`, `python3`, `cargo` (for LSP servers/Mason)

### Setup
1.  **Clone:**
    ```bash
    git clone <your-repo-url> ~/.config/nvim
    ```
2.  **Install Plugins:**
    Start Neovim. `lazy.nvim` will bootstrap automatically.
    Run `:Lazy sync` to ensure everything is clean.
3.  **Install LSPs:**
    Run `:Mason` to verify tools are installed.
    *(LSPs configured in `configs/lspconfig.lua` usually auto-install if missing)*.

---

## 💡 Troubleshooting

*   **Transparency Issues:**
    Transparency is handled natively by themes. If a background appears, ensure `transparent = true` is set in the theme's spec in `plugins/init.lua`.
*   **Harpoon Conflicts:**
    If `<leader>1` etc. don't work, ensure no other plugin is claiming the Leader key in `mappings.lua`.
