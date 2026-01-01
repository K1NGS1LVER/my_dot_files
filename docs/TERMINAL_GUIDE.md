# Neovim as Terminal Replacement Guide

You have configured Neovim to act as your primary terminal environment using `toggleterm.nvim`. This allows you to run bash commands directly inside Neovim, effectively replacing your standard terminal workflow while keeping the power of an editor just a keypress away.

## How It Works

1.  **Auto-Start:** When you open Neovim without any arguments (`nvim`), a floating terminal will automatically open.
2.  **Toggle Key:** Press `<Ctrl-\\>` (Control + Backslash) to toggle the terminal window on and off.
3.  **Insert Mode:** The terminal starts in Insert mode, so you can type commands immediately.

## Keybindings

| Key Shortcut | Action |
| :--- | :--- |
| `<Ctrl-\\>` | Toggle the floating terminal (Open/Close) |
| `<Space>tf` | Open terminal in a floating window |
| `<Space>ts` | Open terminal in a horizontal split |
| `<Space>tv` | Open terminal in a vertical split |

## How to Reset / Undo

If you decide you no longer want Neovim to auto-open the terminal:

1.  Open the file `~/.config/nvim/lua/autocmds.lua`.
2.  Remove the block of code starting with `-- Auto-open ToggleTerm`.

Alternatively, run this command in your shell to restore the default `autocmds.lua`:

```bash
echo 'require "nvchad.autocmds"' > ~/.config/nvim/lua/autocmds.lua
```

## Tips

*   **Multiple Terminals:** You can open multiple terminals by using the `<Space>ts` or `<Space>tv` commands.
*   **Navigation:** To leave the terminal's "Insert" mode and navigate the buffer like a normal text file (e.g., to copy output), press `Ctrl+\\` then `Ctrl+n` (or your configured escape sequence).
