## 📄 PDF Workflow (Sioyek + Neovim)

A terminal-centric PDF reading and annotation workflow has been set up using **Sioyek**. This viewer is optimized for technical reading and configured with Vim-like keybindings.

### 🚀 Usage

**Open a PDF from Neovim with Sioyek:**
```vim
:Pdf filename.pdf
" Or open the current buffer if it is a PDF
:Pdf
```

**Open a PDF from Neovim with default macOS viewer (e.g., Preview.app):**
```vim
:Openpdf filename.pdf
" Or open the current buffer if it is a PDF
:Openpdf
```

### ⌨️ Sioyek Controls (Vim-Bindings)
The configuration is located at `~/.config/sioyek/keys_user.config`.

| Action | Key |
| :--- | :--- |
| **Move Down** | `j` |
| **Move Up** | `k` |
| **Move Left** | `h` |
| **Move Right** | `l` |
| **Next Page** | `<C-d>` |
| **Prev Page** | `<C-u>` |
| **Scroll Screen** | `<Space>` / `<S-Space>` |
| **Go to Page** | `gg` (e.g., `50gg`) |
| **Table of Contents** | `t` |
| **Search** | `/` |
| **Zoom In/Out** | `+` / `-` |
| **Fit Width** | `w` |
| **Highlight** | `i` (then select text) |
| **Go to Mark** | `'` |
| **Command Palette** | `<C-p>` |
| **Toggle Dark Mode** | `<C-r>` |
| **Toggle Custom Color** | `<F8>` |
| **Quit** | `q` |

### ⚙️ Configuration Details
- **Sioyek Config:** `~/.config/sioyek/keys_user.config`
- **Neovim Commands:** Defined in `~/.config/nvim/init.lua` (creates the `:Pdf` and `:Openpdf` user commands).

#### 🎨 Custom Dark Mode Theme
Sioyek is configured to use a custom "rich grey" dark mode theme for easier reading. This is set in `~/.config/sioyek/prefs_user.config`.

**Settings:**
- **Background Color:** `#282828` (soft dark grey)
- **Text Color:** `#ebdbb2` (warm off-white)

This theme is automatically applied on startup. If you ever want to toggle it manually, use `<F8>` within Sioyek.

## 🛠 Terminal Power Tools
The system is now configured for a 100% terminal-centric workflow.

### 📁 Yazi (File Manager)
A blazing fast terminal file manager written in Rust.
*   **Run:** `yazi`
*   **Navigation:** Vim keys (`j`, `k`, `l` to enter, `h` to leave).
*   **Previews:** Supports images, PDFs, and code directly in the terminal.

### 📊 Btop (System Monitor)
A modern replacement for Activity Monitor.
*   **Run:** `btop`
*   **Usage:** Mouse or keyboard to kill processes, monitor CPU/Mem.

### 🌐 Lynx (Text Browser)
A text-based web browser.
*   **Run:** `lynx`
*   **Default Start Page:** DuckDuckGo
*   **Theme:** Custom green/cyan theme defined in `~/.lynx.lss`
*   **VI Keys:** Enabled for navigation.

### 🖥️ Tmux (Multiplexer)
Allows splitting one terminal window into multiple panes.
*   **Run:** `tmux`
*   **Split Vertical:** `Ctrl+b` then `|`
*   **Split Horizontal:** `Ctrl+b` then `-`
*   **Navigate Panes:** `Ctrl+b` then `h/j/k/l`
*   **Mouse:** Enabled (you can click panes to switch).

### 🦁 Brave Browser (Graphical)
Launch the Brave browser from the terminal.
*   **Run:** `brave` (opens default)
*   **Run:** `brave google.com` (opens URL)

---

## 🔧 Technical Configuration Reference
This section documents the specific files and commands used to build this environment.

### 1. ZSH Configuration (`~/.zshrc`)
The following customizations were added to your shell configuration:

**Key Bindings:**
*   Fixed backspace to delete characters instead of words:
    `bindkey "^?" backward-delete-char`

**Aliases & Functions:**
*   **Brave Browser:** Added a smart function `brave()` that accepts URLs (prepending `https://` if needed) or launches the browser empty.
*   **Lynx Theme:** Exported `LYNX_CFG` and `LYNX_LSS` variables to point to custom config files.

### 2. Neovim Configuration (`~/.config/nvim/init.lua`)
*   **PDF Integration:** Added `vim.api.nvim_create_user_command` for `:Pdf` (Sioyek) and `:Openpdf` (Default macOS viewer).
*   **Indent Blankline Fix:** Patched `ibl.hooks` to define `IblScopeChar` highlight group, preventing crashes on C++ files.

### 3. Sioyek Configuration
*   **Keybindings (`~/.config/sioyek/keys_user.config`):** Mapped standard Vim keys (`j/k/h/l`, `gg`, etc.) to Sioyek actions.
*   **Preferences (`~/.config/sioyek/prefs_user.config`):** Defined `custom_background_color` and `custom_text_color` for the "Rich Grey" theme.

### 4. Lynx Configuration
*   **Main Config (`~/.lynx.cfg`):** Enabled `VI_KEYS_ALWAYS_ON`, set `DEFAULT_EDITOR:nvim`, and defined Start Page.
*   **Style Sheet (`~/.lynx.lss`):** Defined custom colors (Cyan links, Green text) for a hacker aesthetic.

### 5. Tmux Configuration (`~/.tmux.conf`)
A custom configuration was created to modernize tmux:
*   **Mouse Support:** `set -g mouse on`
*   **Splitting:** Rebound split keys to `|` (vertical) and `-` (horizontal).
*   **Navigation:** Enabled Vim-style pane switching (`h/j/k/l`).
*   **Status Bar:** Configured a minimal status bar with date/time.

### 🦁 Brave Browser Super-Shortcuts
The `brave` command now supports smart aliases for your frequent sites.

| Command | Site | Searchable? |
| :--- | :--- | :--- |
| `brave yt` / `brave youtube` | YouTube | ✅ Yes (`brave yt funny cats`) |
| `brave gh` / `brave github` | GitHub | ✅ Yes (`brave gh nvim`) |
| `brave rd` / `brave reddit` | Reddit | ✅ Yes (`brave rd memes`) |
| `brave x` / `brave twitter` | X (Twitter) | ✅ Yes |
| `brave li` / `brave linkedin` | LinkedIn | ✅ Yes |
| `brave hi` / `brave hianime` | H!Anime | ✅ Yes |
| `brave gf` / `brave greasyfork` | Greasy Fork | ✅ Yes |
| `brave openjs` | OpenUserJS | ✅ Yes |
| `brave cu` / `brave christ` | Christ University | ❌ Home only |
| `brave cl` / `brave classroom` | Google Classroom | ❌ Home only |
| `brave mt` / `brave monkeytype` | Monkeytype | ❌ Home only |
| `brave kb` / `brave keybr` | Keybr | ❌ Home only |
## ⚙️ Technical Details

This section provides a deep dive into the architecture, dependencies, setup, and usage of the terminal-centric environment.

### 🏛️ Architecture
The core architecture is built around **Zsh** as the primary shell, augmented with a comprehensive set of **Terminal User Interface (TUI)** applications and **Neovim** as the central text editor. Interactions are heavily keyboard-driven, minimizing mouse usage and context switching away from the terminal. Shell functions and aliases (`~/.zshrc`) serve as the integration layer, launching and managing TUI applications or custom Neovim commands.

### 📦 Dependencies
The following tools and their dependencies were installed via Homebrew:

```bash
brew install yazi btop lynx ffmpeg sevenzip jq poppler imagemagick
```
*   **`yazi`**: Fast, Rust-based terminal file manager.
*   **`btop`**: Resource monitor (CPU, Memory, Disk, Network).
*   **`lynx`**: Text-based web browser.
*   **`ffmpeg`**: Multimedia framework, used by Yazi for video previews.
*   **`sevenzip`**: 7-Zip archiver, used by Yazi for archive previews.
*   **`jq`**: JSON processor, used by Yazi for JSON file previews.
*   **`poppler`**: PDF rendering library, used by Yazi for PDF previews.
*   **`imagemagick`**: Image processing tool, used by Sioyek and Yazi for image/PDF previews.
*   **`sioyek` (Cask)**: PDF viewer (GUI, but keyboard-driven and launched from terminal).

### 🛠️ Setup & Configuration
Key configuration changes were applied to the following files:

#### `~/.zshrc`
*   **BackSpace Fix:** Ensures Backspace deletes character by character.
    ```bash
    bindkey "^?" backward-delete-char
    ```
*   **Brave Browser Function:** A smart function that launches Brave Browser, handling direct URLs, and providing shortcuts for common sites with optional search queries.
    ```bash
    # Brave Browser Super-Function
    brave() {
        local target_url
        local base
        local search_url

        if [[ -z "$1" ]]; then
            open -a "Brave Browser"
            return
        fi

        case "$1" in
            youtube|yt)
                base="https://www.youtube.com"
                search_url="${base}/results?search_query=" ;; 
            github|gh)
                base="https://github.com"
                search_url="${base}/search?q=" ;; 
            linkedin|li)
                base="https://www.linkedin.com"
                search_url="${base}/search/results/all/?keywords=" ;; 
            christ|cu)
                base="https://christuniversity.in"
                search_url="" ;; 
            hianime|hi)
                base="https://hianimez.is/home"
                search_url="https://hianimez.is/search?keyword=" ;; 
            monkeytype|mt)
                base="https://monkeytype.com"
                search_url="" ;; 
            keybr|kb)
                base="https://www.keybr.com"
                search_url="" ;; 
            greasyfork|gf)
                base="https://greasyfork.org"
                search_url="${base}/scripts/search?q=" ;; 
            openjs)
                base="https://openuserjs.org"
                search_url="${base}/?q=" ;; 
            classroom|cl)
                base="https://classroom.google.com"
                search_url="" ;; 
            reddit|rd)
                base="https://www.reddit.com"
                search_url="${base}/search/?q=" ;; 
            x|twitter)
                base="https://x.com"
                search_url="${base}/search?q=" ;; 
            *)
                if [[ "$1" != http* ]]; then
                     open -a "Brave Browser" "https://$1"
                else
                     open -a "Brave Browser" "$1"
                fi
                return ;; 
        esac

        shift
        if [[ -z "$1" ]]; then
            target_url="$base"
        else
            if [[ -z "$search_url" ]]; then
                target_url="$base"
            else
                local query=$(printf "%%s+" "$@")
                query=${query%%+};
                target_url="${search_url}${query}"
            fi
        fi
        open -a "Brave Browser" "$target_url"
    }
    ```
*   **Lynx Config Paths:** Set environment variables to point Lynx to custom config and style files.
    ```bash
    export LYNX_CFG=~/.lynx.cfg
    export LYNX_LSS=~/.lynx.lss
    ```

#### `~/.config/nvim/init.lua`
*   **Sioyek PDF Command:** Custom Neovim command to open PDFs with Sioyek.
    ```lua
    vim.api.nvim_create_user_command('Pdf', function(opts)
      local filepath = opts.args
      if filepath == "" then filepath = vim.fn.expand('%:p') end
      vim.fn.jobstart({'open', '-a', 'sioyek', filepath}, {detach = true})
    end, { nargs = '?', complete = 'file' })
    ```
*   **Default PDF Command:** Custom Neovim command to open PDFs with macOS's default viewer.
    ```lua
    vim.api.nvim_create_user_command('Openpdf', function(opts)
      local filepath = opts.args
      if filepath == "" then filepath = vim.fn.expand('%:p') end
      vim.fn.jobstart({'open', filepath}, {detach = true})
    end, { nargs = '?', complete = 'file' })
    ```
*   **Indent Blankline Fix:** Ensures `IblScopeChar` highlight group is defined for `indent-blankline.nvim`.
    ```lua
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, "IblChar", { fg = "#565f89" })
        vim.api.nvim_set_hl(0, "IblScopeChar", { fg = "#565f89" })
      end)
    ```

#### `~/.config/sioyek/keys_user.config`
*   **Vim-like Keybindings:** Configured for navigation, search, and essential Sioyek actions.
    ```ini
    move_down           j
    move_up             k
    move_left           h
    move_right          l
    next_page           <C-d>
    previous_page       <C-u>
    screen_down         <space>
    screen_up           <S-space>
    goto_toc            t
    zoom_in             +
    zoom_out            -
    fit_to_screen_width w
    add_highlight       i
    goto_mark           '
    command             :
    command_palette     <C-p>
    toggle_dark_mode    <C-r>
    toggle_custom_color <F8>
    quit                q
    ```

#### `~/.config/sioyek/prefs_user.config`
*   **Custom Dark Mode Theme:** Defines colors for the "Rich Grey" theme.
    ```ini
    custom_background_color  0.157 0.157 0.157
    custom_text_color        0.92 0.86 0.70
    startup_commands toggle_custom_color
    ```

#### `~/.lynx.cfg`
*   **Lynx Preferences:** Sets start page, default editor, and VI key mode.
    ```ini
    STARTFILE:https://duckduckgo.com
    DEFAULT_EDITOR:nvim
    VI_KEYS_ALWAYS_ON:TRUE
    EMACS_KEYS_ALWAYS_ON:FALSE
    DEFAULT_KEYPAD_MODE:NUMBERS_AS_ARROWS
    NUMBER_LINKS_ON_LEFT:TRUE
    NOMENU:FALSE
    ```

#### `~/.lynx.lss`
*   **Lynx Color Scheme:** Defines a custom green/cyan theme.
    ```ini
    normal:		normal:			default:default
    em:		bold:			brightgreen:default
    strong:		bold:			brightred:default
    b:		bold:			brightred:default
    a:		bold:			cyan:default
    h1:		bold:			yellow:default
    h2:		bold:			yellow:default
    h3:		bold:			yellow:default
    h4:		bold:			yellow:default
    h5:		bold:			yellow:default
    h6:		bold:			yellow:default
    ```

#### `~/.tmux.conf`
*   **Tmux Configuration:** Modernizes tmux with mouse support, improved pane management, and Vim-like navigation.
    ```ini
    # -- General --
    set -g mouse on
    set -g base-index 1
    setw -g pane-base-index 1
    set -g renumber-windows on
    set -g history-limit 10000

    # -- Key Bindings (Vim Style) --
    set-window-option -g mode-keys vi
    bind h select-pane -L
    bind j select-pane -D
    bind k select-pane -U
    bind l select-pane -R

    # -- Split Panes --
    bind | split-window -h -c "#{pane_current_path}"
    bind - split-window -v -c "#{pane_current_path}"
    unbind "'"
    unbind % 

    # -- Reload Config --
    bind r source-file ~/.tmux.conf \; display "Config Reloaded!"

    # -- Status Bar (Minimal) --
    set -g status-bg default
    set -g status-fg white
    set -g status-left ""
    set -g status-right "#[fg=green]%%H:%%M #[fg=blue]%%d-%%b"
    ```

### 🚀 Usage Verification & Testing
*   **Shell Configuration:** After any changes to `~/.zshrc`, run `source ~/.zshrc` or open a new terminal session.
*   **Brave Browser:** Test with `brave`, `brave youtube`, `brave gh nvim`.
*   **Neovim Commands:** Open Neovim, then test `:Pdf path/to/file.pdf` and `:Openpdf path/to/file.pdf`.
*   **Sioyek:** Launch via Neovim, verify keybindings, command palette (`<C-p>`), and dark mode (`<F8>` or `<C-r>`).
*   **Lynx:** Launch `lynx`, verify start page, colors, and navigation.
*   **Tmux:** Launch `tmux`, test pane splitting, navigation (`<Ctrl+b> h/j/k/l`), and mouse support.
*   **Yazi/Btop:** Launch `yazi` and `btop` directly from the terminal.


--- 

## 📜 Setup Commands Log

This section documents the specific shell commands used to generate the configuration files and directory structures described above. This serves as a reproducible log of the setup process.

### 1. Directory Creation
Commands to ensure necessary configuration directories exist:

```bash
mkdir -p ~/.config/yazi ~/.config/tmux ~/.config/sioyek ~/.config/nvim/lua/plugins
```

### 2. Sioyek Configuration Generation
Commands used to create the user keybindings and preference files:

**Keybindings (`~/.config/sioyek/keys_user.config`):**
```bash
printf "move_down           j\nmove_up             k\nmove_left           h\nmove_right          l\nnext_page           <C-d>\nprevious_page       <C-u>\nscreen_down         <space>\nscreen_up           <S-space>\ngoto_toc            t\nzoom_in             +\nzoom_out            -\nfit_to_screen_width w\nadd_highlight       i\ngoto_mark           '\n\n# --- Missing Essentials ---
command             :\ncommand_palette     <C-p>\ntoggle_dark_mode    <C-r>\ntoggle_custom_color <F8>\nquit                q\n" > ~/.config/sioyek/keys_user.config
```

**Preferences (`~/.config/sioyek/prefs_user.config`):**
```bash
printf "custom_background_color  0.157 0.157 0.157\ncustom_text_color        0.92 0.86 0.70\n\nstartup_commands toggle_custom_color\n" > ~/.config/sioyek/prefs_user.config
```

### 3. Lynx Configuration Generation
Commands used to create the Lynx configuration and style sheet:

**Main Config (`~/.lynx.cfg`):**
```bash
printf "STARTFILE:https://duckduckgo.com\nDEFAULT_EDITOR:nvim\nVI_KEYS_ALWAYS_ON:TRUE\nEMACS_KEYS_ALWAYS_ON:FALSE\nDEFAULT_KEYPAD_MODE:NUMBERS_AS_ARROWS\nNUMBER_LINKS_ON_LEFT:TRUE\nNOMENU:FALSE\n" > ~/.lynx.cfg
```

**Style Sheet (`~/.lynx.lss`):**
```bash
printf "normal: 		normal: 		default:default\nem: 		bold: 			brightgreen:default\nstrong: 	bold: 			brightred:default\nb: 		bold: 			brightred:default\na: 		bold: 			cyan:default\nh1: 		bold: 			yellow:default\nh2: 		bold: 			yellow:default\nh3: 		bold: 			yellow:default\nh4: 		bold: 			yellow:default\nh5: 		bold: 			yellow:default\nh6: 		bold: 			yellow:default\n" > ~/.lynx.lss
```

### 4. Tmux Configuration Generation
Command used to create the modern `~/.tmux.conf`:

```bash
printf "# -- General --\nset -g mouse on\nset -g base-index 1\nsetw -g pane-base-index 1\nset -g renumber-windows on\nset -g history-limit 10000\n\n# -- Key Bindings (Vim Style) --\nset-window-option -g mode-keys vi\nbind h select-pane -L\nbind j select-pane -D\nbind k select-pane -U\nbind l select-pane -R\n\n# -- Split Panes --\nbind | split-window -h -c \"#{pane_current_path}\"\nbind - split-window -v -c \"#{pane_current_path}\"\nunbind '"'\nunbind %%\n\n# -- Reload Config --\nbind r source-file ~/.tmux.conf \; display \"Config Reloaded!\"\n\n# -- Status Bar (Minimal) --\nset -g status-bg default\nset -g status-fg white\nset -g status-left \"\"\nset -g status-right \"#[fg=green]%%H:%%M #[fg=blue]%%d-%%b\"\n" > ~/.tmux.conf
```

### 5. Neovim Integration
Commands used to append PDF integration to `~/.config/nvim/init.lua`:

```bash
printf "\n-- PDF Viewer (Sioyek) Integration\nvim.api.nvim_create_user_command('Pdf', function(opts)\n  local filepath = opts.args\n  if filepath == \"\" then filepath = vim.fn.expand('%%:p') end\n  vim.fn.jobstart({'open', '-a', 'sioyek', filepath}, {detach = true})\nend, { nargs = '?', complete = 'file' })
" >> ~/.config/nvim/init.lua

printf "\n-- Open PDF with default macOS viewer\nvim.api.nvim_create_user_command('Openpdf', function(opts)\n  local filepath = opts.args\n  if filepath == \"\" then filepath = vim.fn.expand('%%:p') end\n  vim.fn.jobstart({'open', filepath}, {detach = true})\nend, { nargs = '?', complete = 'file' })
" >> ~/.config/nvim/init.lua
```

### 6. ZSH Configuration
Commands used to append the Lynx theme paths and the Brave browser function to `~/.zshrc`:

```bash
printf "\n# --- Lynx Browser Theme ---\nexport LYNX_CFG=~/.lynx.cfg\nexport LYNX_LSS=~/.lynx.lss\n" >> ~/.zshrc

printf "\n# Brave Browser Super-Function\nbrave() {\n ... (function content) ... \n}\n" >> ~/.zshrc
```
*(Note: Full function content omitted here for brevity, refer to "Technical Details" section above).*


## 🚀 Updated Tmux Configuration

Your `~/.tmux.conf` has been updated with a more ergonomic and powerful configuration:

*   **Primary Prefix:** `Ctrl+a` (press `Ctrl` and `a` together, then release and press your command)
*   **Alternate Prefix:** `Ctrl+b` (this also acts as a prefix, internally sending `Ctrl+a`)
*   **Mouse Support:** Enabled (you can click to switch panes, scroll through history, and resize panes with the mouse).
*   **Intuitive Splits:**
    *   `Prefix + |` (pipe key) to split the current pane **vertically** (`Prefix` being either `Ctrl+a` or `Ctrl+b`).
    *   `Prefix + -` (hyphen key) to split the current pane **horizontally** (`Prefix` being either `Ctrl+a` or `Ctrl+b`).
*   **Vim-style Pane Navigation:**
    *   `Prefix + h` to move to the pane on the **left**.
    *   `Prefix + j` to move to the pane **down**.
    *   `Prefix + k` to move to the pane **up**.
    *   `Prefix + l` to move to the pane on the **right**.
*   **Reload Configuration:** `Prefix + r` to reload your `~/.tmux.conf` file after making changes.

To ensure these settings are active, start a new `tmux` session, or if you're already in a session, use the `Prefix + r` command.


## ⌨️ Karabiner-Elements (Caps Lock Dual Function)

Karabiner-Elements is configured to enhance keyboard ergonomics, specifically by turning the Caps Lock key into a powerful dual-function key.

*   **Tap Caps Lock:** Sends  (ideal for exiting Insert mode in Vim/Neovim).
*   **Hold Caps Lock:** Sends  (perfect for your  Tmux prefix and other terminal commands).

### Configuration Rule Applied:

**Rule Name:** "Change Caps Lock to Control if pressed with other keys, to Escape if pressed alone."

**Technical Details (as seen in the rule JSON):**
```json
{
  "title": "Caps→Ctrl/Esc if alone",
  "description": "Caps→Esc/Ctrl if held",
  "manipulators": [
    {
      "from": {
        "key_code": "caps_lock",
        "modifiers": {
          "optional": [
            "any"
          ]
        }
      },
      "to": [
        {
          "key_code": "left_control"
        }
      ],
      "to_if_alone": [
        {
          "key_code": "escape"
        }
      ],
      "type": "basic"
    }
  ]
}
```

### How to Verify/Enable (if needed):

1.  Open **Karabiner-Elements** application.
2.  Go to the **Complex Modifications** tab.
3.  Ensure the rule titled "Change Caps Lock to Control if pressed with other keys, to Escape if pressed alone." is **Enabled**.


## ⌨️ Karabiner-Elements (Caps Lock Dual Function)

Karabiner-Elements is configured to enhance keyboard ergonomics, specifically by turning the Caps Lock key into a powerful dual-function key.

*   **Tap Caps Lock:** Sends `Escape` (ideal for exiting Insert mode in Vim/Neovim).
*   **Hold Caps Lock:** Sends `Control` (perfect for your `Ctrl+a` Tmux prefix and other terminal commands).

### Configuration Rule Applied:

**Rule Name:** "Change Caps Lock to Control if pressed with other keys, to Escape if pressed alone."

**Technical Details (as seen in the rule JSON):**
```json
{
  "title": "Caps→Ctrl/Esc if alone",
  "description": "Caps→Esc/Ctrl if held",
  "manipulators": [
    {
      "from": {
        "key_code": "caps_lock",
        "modifiers": {
          "optional": [
            "any"
          ]
        }
      },
      "to": [
        {
          "key_code": "left_control"
        }
      ],
      "to_if_alone": [
        {
          "key_code": "escape"
        }
      ],
      "type": "basic"
    }
  ]
}
```

### How to Verify/Enable (if needed):

1.  Open **Karabiner-Elements** application.
2.  Go to the **Complex Modifications** tab.
3.  Ensure the rule titled "Change Caps Lock to Control if pressed with other keys, to Escape if pressed alone." is **Enabled**.

## 🔄 Professional Tmux Workflow

This workflow is designed to maximize productivity by treating Tmux sessions as persistent project workspaces.

### 1. The Core Concept: "One Session Per Project"
Instead of cluttering a single session, create dedicated named sessions for each context (e.g., 'backend', 'frontend', 'infra').

### 2. Standard "Cockpit" Layout
A recommended pane layout for development:
*   **Left Pane (50-70%):** Code Editor (`nvim`)
*   **Top-Right Pane:** Server Logs / Build Process
*   **Bottom-Right Pane:** Shell for Git commands or File Management (`yazi`)

**How to build it:**
1.  Start session: `tmux new -s project_name`
2.  Open Neovim.
3.  Split vertically: `Prefix + |`
4.  Split the new right pane horizontally: `Prefix + -`

### 3. Context Switching (The Superpower)
Switch between projects instantly without losing state.

*   **Detach (Pause):** `Prefix + d` returns you to the normal shell, leaving the session running in the background.
*   **Resume:** `tmux attach -t project_name` (or just `tmux a` for the last session).
*   **Switch Sessions:** `Prefix + s` opens an interactive list of all running sessions. Use `j/k` to select and `Enter` to switch.

### 4. Session Commands Cheat Sheet
*   **Start New:** `tmux new -s name`
*   **List All:** `tmux ls`
*   **Attach:** `tmux a -t name`
*   **Kill:** `tmux kill-session -t name`
