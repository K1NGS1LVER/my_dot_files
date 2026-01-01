# NvChad Terminal Development Setup Guide

## 🚀 Your Setup is Almost Ready!

NvChad v2.5 is configured with essential plugins for complete terminal-based development.

## 📦 Installation Steps

### 1. Install Required Tools

```bash
# Install lazygit (for Git management)
brew install lazygit

# Install ripgrep and fd (for better search)
brew install ripgrep fd

# Install Node.js (required for many LSP servers)
brew install node

# Optional but recommended
brew install tmux       # Terminal multiplexer
brew install fzf        # Fuzzy finder
```

### 2. Open Neovim and Install Plugins

```bash
nvim
```

When you first open Neovim:

- Plugins will automatically install (wait for it to complete)
- Press `<Space>` to see available commands (your leader key)

### 3. Install Language Servers

Press `:` then type:

```
MasonInstall lua-language-server stylua prettier
```

Install language servers for your languages:

```
# JavaScript/TypeScript
MasonInstall typescript-language-server eslint-lsp prettier

# Python
MasonInstall pyright black

# Go
MasonInstall gopls gofmt

# Rust
MasonInstall rust-analyzer

# Docker
MasonInstall dockerfile-language-server

# Bash
MasonInstall bash-language-server shfmt

# JSON/YAML
MasonInstall json-lsp yaml-language-server
```

Or open Mason UI with: `:Mason`

## 🔑 Essential Keybindings

### General

- `Space` - Leader key (opens which-key menu)
- `;` - Enter command mode (instead of `:`)
- `jk` - Exit insert mode (instead of Esc)
- `Ctrl+s` - Save file
- `Space w` - Save file
- `Space q` - Quit
- `Esc` - Clear search highlight

### File Navigation

- `Space ff` - Find files (Telescope)
- `Space fw` - Find word in files
- `Space fb` - Find buffers
- `Space fo` - Find old files (recent)
- `Space fz` - Find in current buffer
- `Space ft` - Find TODO comments
- `Ctrl+n` - Toggle file tree

### Window Management

- `Ctrl+h/j/k/l` - Navigate between windows
- `Ctrl+Up/Down/Left/Right` - Resize windows
- `Space h` - New horizontal split
- `Space v` - New vertical split

### Buffer Navigation

- `Shift+h` - Previous buffer
- `Shift+l` - Next buffer
- `Space bd` - Delete buffer
- `Tab` - Next buffer (alternative)

### Terminal

- `Ctrl+\` - Toggle floating terminal
- `Space tf` - Floating terminal
- `Space th` - Horizontal terminal
- `Space tv` - Vertical terminal
- `Alt+i` - Toggle terminal (in terminal mode)
- `Alt+h/v` - Horizontal/Vertical terminal

### Git (LazyGit)

- `Space gg` - Open LazyGit

### LSP (Code Intelligence)

- `gd` - Go to definition
- `gr` - Go to references
- `gI` - Go to implementation
- `gy` - Go to type definition
- `gD` - Go to declaration
- `K` - Show hover documentation
- `Space ca` - Code action
- `Space rn` - Rename symbol
- `Space lf` - Format code
- `[d` - Previous diagnostic
- `]d` - Next diagnostic
- `Space e` - Show diagnostic float

### Debugging

- `Space db` - Toggle breakpoint
- `Space dc` - Continue
- `Space di` - Step into
- `Space do` - Step over
- `Space dO` - Step out
- `Space du` - Toggle debug UI

### Diagnostics & Errors

- `Space xx` - Show all diagnostics (Trouble)
- `Space xX` - Show buffer diagnostics
- `Space xl` - Show location list
- `Space xq` - Show quickfix list

### Editing

- `gcc` - Toggle line comment
- `gc` (visual mode) - Toggle comment for selection
- `>` / `<` (visual mode) - Indent right/left (stay in visual)
- `Alt+j/k` - Move line up/down
- `p` (visual mode) - Paste without yanking

### Search & Replace

- `/` - Search forward
- `?` - Search backward
- `n` / `N` - Next/previous search result (centered)
- `*` - Search for word under cursor

### Sessions

- `Space qs` - Restore session for current directory
- `Space ql` - Restore last session
- `Space qd` - Don't save current session

## 🎨 Themes

Change theme by editing `~/.config/nvim/lua/chadrc.lua`:

Popular themes available:

- `catppuccin` (current)
- `tokyonight`
- `gruvbox`
- `nord`
- `onedark`
- `everforest`

Preview themes: `Space th` (type theme name)

## 🔧 Configuration Files

```
~/.config/nvim/
├── init.lua                    # Main config entry point
├── lua/
│   ├── chadrc.lua              # NvChad UI config (theme, statusline)
│   ├── options.lua             # Vim options
│   ├── mappings.lua            # Key mappings
│   ├── autocmds.lua            # Auto commands
│   ├── plugins/
│   │   └── init.lua            # Plugin specifications
│   └── configs/
│       ├── lspconfig.lua       # LSP server config
│       ├── conform.lua         # Formatter config
│       └── lazy.lua            # Lazy.nvim config
```

## 🎯 Installed Plugins

### Core Functionality

- **NvChad** - Base configuration and UI
- **lazy.nvim** - Plugin manager
- **nvim-treesitter** - Syntax highlighting
- **nvim-lspconfig** - LSP support
- **Mason** - LSP/formatter installer
- **conform.nvim** - Code formatting (auto-format on save)
- **telescope.nvim** - Fuzzy finder
- **nvim-tree** - File explorer

### Development Tools

- **toggleterm** - Better terminal integration
- **lazygit** - Git UI
- **gitsigns** - Git decorations
- **nvim-dap** - Debugging support
- **dap-ui** - Debug UI
- **trouble.nvim** - Better diagnostics
- **todo-comments** - Highlight TODO comments

### Editing

- **Comment.nvim** - Smart commenting
- **nvim-surround** - Surround text objects
- **nvim-autopairs** - Auto pairs
- **indent-blankline** - Indent guides

### Quality of Life

- **which-key** - Keybinding hints
- **persistence.nvim** - Session management
- **nvim-bqf** - Better quickfix
- **LuaSnip** - Snippet engine

## 🚀 Quick Start Workflow

1. **Open your project:**

   ```bash
   cd your-project
   nvim
   ```

2. **Find and open files:**
   - `Space ff` to fuzzy find files
   - `Space fw` to search text in project

3. **Edit code with LSP:**
   - Hover over code with `K` for docs
   - Use `gd` to jump to definitions
   - `Space ca` for code actions

4. **Terminal workflow:**
   - `Ctrl+\` to open terminal
   - Run commands, exit terminal
   - `Ctrl+\` to toggle back

5. **Git workflow:**
   - `Space gg` to open LazyGit
   - Stage, commit, push from TUI

6. **Save session:**
   - Close nvim normally
   - Next time: `Space qs` to restore

## 🐛 Troubleshooting

### Plugins not loading

```
:Lazy sync
```

### LSP not working

```
:Mason
# Install required language server
```

### Treesitter parsing errors

```
:TSUpdate
```

### Clear cache

```bash
rm -rf ~/.local/share/nvim
rm -rf ~/.cache/nvim
```

## 📚 Learning Resources

- **Which-key**: Press `Space` and wait to see all available commands
- **Built-in help**: `:help <topic>`
- **NvChad docs**: https://nvchad.com
- **Neovim docs**: https://neovim.io/doc

## 🎓 Tips for Beginners

1. **Start with basics**: Master navigation (hjkl), insert mode (i), save (:w), quit (:q)
2. **Use which-key**: Press `Space` and wait to discover commands
3. **One plugin at a time**: Don't try to learn everything at once
4. **Read docs**: Use `:help` extensively
5. **Practice**: Muscle memory takes time

## 🔥 Advanced Tips

- Use `gf` to go to file under cursor
- `Ctrl+o` / `Ctrl+i` to jump back/forward in jump list
- `.` to repeat last change
- `*` to search for word under cursor
- Visual block mode: `Ctrl+v`
- Macros: `q<letter>` to record, `@<letter>` to replay

---

**Enjoy your terminal-based development setup! 🎉**
