# 🛡️ Conflict Audit & Resolution Log

This document tracks identified keybinding and event conflicts within the development environment and their resolutions.

## 🕒 Last Audit: December 26, 2025

### 🔴 Resolved Critical Conflicts

#### 1. Neovim: `<leader>e` Double Bind
- **Conflict:** `<leader>e` was mapped to both `Diagnostics` and `NvimTreeToggle`.
- **Impact:** Diagnostics were unreachable; Explorer opened instead.
- **Resolution:** 
    - Moved **Diagnostics** to `<leader>d`.
    - Kept **Explorer** on `<leader>e`.

#### 2. Neovim: `<C-\`> Collision
- **Conflict:** `toggleterm.nvim` and `vim-tmux-navigator` both used `Ctrl+\`.
- **Impact:** Unpredictable behavior when toggling terminals or navigating panes.
- **Resolution:** 
    - Rebound **ToggleTerm** to `Ctrl+t`.

### 🟠 Resolved High Severity Conflicts

#### 3. Neovim: Shadowed Leader Keys (Lag)
- **Conflict:** `<leader>q` (Quit) shadowed `<leader>qs` (Session management).
- **Impact:** 1-second delay when trying to quit while Neovim waited for potential follow-up keys.
- **Resolution:** 
    - Rebound **Quit** to `<leader>qq`.

#### 4. Browser Function: Relative Paths
- **Conflict:** `brave yt "query"` failed because it interpreted `/results...` as a local file path.
- **Impact:** Search shortcuts in the `brave` function were broken.
- **Resolution:** 
    - Updated `brave` function to detect relative search paths and prepend the base URL.

### 🟡 Identified Ongoing Conflicts

#### 5. `Ctrl+a` Prefix (Tmux vs Shell)
- **Conflict:** Tmux prefix is `Ctrl+a`, which conflicts with Zsh's "Beginning of Line".
- **Status:** *Acceptance*. User must press `Ctrl+a` twice to jump to the start of a line in the shell.
- **Resolution:** No action taken to preserve Tmux habits.

---

## 🛠️ Summary of Changes Applied
1. **Mappings Updated:** `<leader>qq` (Quit), `<leader>d` (Diagnostics), `<leader>o` (Focus Tree).
2. **Plugin Settings:** `toggleterm` now uses `Ctrl+t`.
3. **Shell Aliases:** `read` now opens Apple Books; `tsr` handles TypeScript module conflicts.
4. **Brave Function:** Fixed relative URL parsing and added `google`/`g` shortcuts.
