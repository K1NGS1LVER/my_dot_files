# System Configuration Inventory & Map

## 1. Shell Environment (Zsh)
**Main Config:** `~/.zshrc`
**Prompt Config:** `~/.p10k.zsh`

### Installed Plugins (Oh-My-Zsh)
- **git**: Aliases for git (gaa, gcmsg, etc.)
- **zsh-autosuggestions**: Grey text completion based on history.
- **zsh-syntax-highlighting**: Green/Red highlighting for commands.

### Custom Functions
- `cap`: Captures command output to file.
- `rec`: Records session script.
- `brave`: Smart browser launcher (supports search shortcuts like `gh`, `yt`).
- `y`: Wrapper for `yazi` file manager.
- `read`: Opens files in Apple Books.
- `tsr`: TypeScript runner (fixes Node version conflicts).

### Installed Aliases
- `fetch`: alias for `fastfetch`.
- `g`: alias for `brave google`.
- `play`: alias for `mpv` (CLI Video Player).
- `watch`: alias for `open -a IINA` (GUI Video Player).

---

## 2. Editor (Neovim / NvChad)
**Config Directory:** `~/.config/nvim/`
**Main Customization:** `~/.config/nvim/lua/chadrc.lua`
**Plugin List:** `~/.config/nvim/lua/plugins/init.lua`
**Audit Log:** `~/readme/CONFLICT_AUDIT.md`

### Key Plugins
- **Catppuccin**: Theme (Configured for global transparency).
- **Harpoon**: Fast file navigation.
- **Obsidian**: Note taking integration.
- **Render-Markdown**: Better markdown viewing.
- **Tmux-Navigator**: Seamless window switching between vim and tmux.

### Key Mappings
- `Space + t + t`: Toggle Global Transparency.
- `Space + t + h`: Switch Theme.
- `Space + f + o`: Quick switch to Obsidian note.

---

## 3. Multiplexer (Tmux)
**Config File:** `~/.tmux.conf`
**Prefix Key:** `Ctrl + A`

### Features
- **Mouse Mode:** Enabled (Click to select panes).
- **Vim Navigation:** `Ctrl + h/j/k/l` to move between panes.
- **Theme:** Catppuccin Mocha (Manual config).

---

## 4. Debugging & Maintenance
- **Reload Shell:** `source ~/.zshrc`
- **Reload Tmux:** `tmux source ~/.tmux.conf`
- **Check Nvim Health:** Open nvim and run `:checkhealth`
- **Manage Nvim Plugins:** Open nvim and run `:Lazy`
