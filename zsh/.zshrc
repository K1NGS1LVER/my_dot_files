typeset -U path PATH

path=(
    $HOME/dotfiles/scripts
    /opt/homebrew/bin
    /opt/homebrew/sbin
    /usr/local/bin
    /usr/bin
    /bin
    /usr/sbin
    /sbin
    $HOME/.local/bin
    $HOME/.cargo/bin
    $HOME/.local/share/nvim/mason/bin
    $HOME/.local/share/bob/nvim-bin
    /opt/homebrew/opt/openjdk/bin
    /Applications/Android Studio.app/Contents/MacOS
    $HOME/Library/pnpm
    $path
)

export EDITOR="nvim"
export JAVA_HOME=$(/usr/libexec/java_home)
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export BAT_THEME="Catppuccin Macchiato"
export LYNX_CFG="$HOME/.lynx.cfg"
export LYNX_LSS="$HOME/.lynx.lss"
export PNPM_HOME="$HOME/Library/pnpm"
export ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
export ZSH_HIGHLIGHT_MAXLENGTH=300
export ZSH_AUTOSUGGEST_USE_ASYNC=1

setopt auto_cd
setopt interactive_comments

autoload -Uz compinit bashcompinit
[[ -f "$ZSH_CUSTOM/plugins/zsh-completions/zsh-completions.plugin.zsh" ]] && source "$ZSH_CUSTOM/plugins/zsh-completions/zsh-completions.plugin.zsh"
mkdir -p "$HOME/.cache/zsh"
compinit -d "$HOME/.cache/zsh/zcompdump-$ZSH_VERSION"
bashcompinit

[[ -f "$ZSH_CUSTOM/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" ]] && source "$ZSH_CUSTOM/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
[[ -f "$ZSH_CUSTOM/plugins/fzf-tab/fzf-tab.plugin.zsh" ]] && source "$ZSH_CUSTOM/plugins/fzf-tab/fzf-tab.plugin.zsh"
[[ -f "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]] && source "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

fuck() {
    unfunction fuck
    eval "$(thefuck --alias)"
    fuck "$@"
}

# --- FZF-TAB CONFIGURATION ---
# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
# zstyle ':completion:*' menu no
# preview directory's content with eza when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
# preview file content with bat when completing other commands
zstyle ':fzf-tab:complete:*:*' fzf-preview 'bat --color=always --style=numbers --line-range=:500 $realpath'
# switch group using < and >
zstyle ':fzf-tab:*' switch-group '<' '>'


# --- CATPPUCCIN MACCHIATO THEME ---
export CATPPUCCIN_ROSEWATER="#f4dbd6"
export CATPPUCCIN_FLAMINGO="#f0c1ce"
export CATPPUCCIN_PINK="#f5bde6"
export CATPPUCCIN_MAUVE="#c6a0f6"
export CATPPUCCIN_RED="#ed8796"
export CATPPUCCIN_MAROON="#ee99a0"
export CATPPUCCIN_PEACH="#f5a97f"
export CATPPUCCIN_YELLOW="#eed49f"
export CATPPUCCIN_GREEN="#a6da95"
export CATPPUCCIN_TEAL="#8bd5ca"
export CATPPUCCIN_SKY="#91d7e3"
export CATPPUCCIN_SAPPHIRE="#7dc4e4"
export CATPPUCCIN_BLUE="#8aadf4"
export CATPPUCCIN_LAVENDER="#b7bdf8"
export CATPPUCCIN_TEXT="#cad3f5"
export CATPPUCCIN_SUBTEXT1="#b8c0e0"
export CATPPUCCIN_SUBTEXT0="#a5adcb"
export CATPPUCCIN_OVERLAY2="#939ab7"
export CATPPUCCIN_OVERLAY1="#8087a2"
export CATPPUCCIN_OVERLAY0="#6e738d"
export CATPPUCCIN_SURFACE2="#5b6078"
export CATPPUCCIN_SURFACE1="#494d64"
export CATPPUCCIN_SURFACE0="#363a4f"
export CATPPUCCIN_BASE="#24273a"
export CATPPUCCIN_MANTLE="#1e2030"
export CATPPUCCIN_CRUST="#181926"

# FZF Catppuccin Macchiato
export FZF_DEFAULT_OPTS=" \
--color=bg+:$CATPPUCCIN_SURFACE0,bg:$CATPPUCCIN_BASE,spinner:$CATPPUCCIN_ROSEWATER,hl:$CATPPUCCIN_RED \
--color=fg:$CATPPUCCIN_TEXT,header:$CATPPUCCIN_RED,info:$CATPPUCCIN_MAUVE,pointer:$CATPPUCCIN_ROSEWATER \
--color=marker:$CATPPUCCIN_ROSEWATER,fg+:$CATPPUCCIN_TEXT,prompt:$CATPPUCCIN_MAUVE,hl+:$CATPPUCCIN_RED"

# Zsh Syntax Highlighting Styles
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[command]='fg=#8aadf4' # Blue
ZSH_HIGHLIGHT_STYLES[alias]='fg=#8bd5ca'   # Teal
ZSH_HIGHLIGHT_STYLES[autid-command]='fg=#8aadf4'
ZSH_HIGHLIGHT_STYLES[function]='fg=#8aadf4'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=#8aadf4'
ZSH_HIGHLIGHT_STYLES[keyword]='fg=#c6a0f6' # Mauve
ZSH_HIGHLIGHT_STYLES[string]='fg=#a6da95'  # Green
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=#f5a97f' # Peach
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=#f5a97f'
ZSH_HIGHLIGHT_STYLES[path]='fg=#f4dbd6'    # Rosewater
ZSH_HIGHLIGHT_STYLES[path_prefix]='fg=#f4dbd6'
ZSH_HIGHLIGHT_STYLES[path_approx]='fg=#f4dbd6'
ZSH_HIGHLIGHT_STYLES[globbing]='fg=#f5bde6' # Pink

command -v zoxide >/dev/null 2>&1 && eval "$(zoxide init zsh --cmd cd)"
command -v atuin >/dev/null 2>&1 && eval "$(atuin init zsh --disable-up-arrow)"
[[ "$TERM" != "dumb" ]] && command -v starship >/dev/null 2>&1 && eval "$(starship init zsh)"

# --- KOTLIN ALIASES ---
alias k='kotlin'        # REPL
alias kc='kotlinc'      # Compiler

# Compile, Run, and Cleanup (Like 'go run')
krun() {
    if [[ -z "$1" ]]; then
        echo "Usage: krun <file.kt>"
        return 1
    fi
    local file="$1"
    local name="${file%.*}"
    # Compile to temporary jar
    kotlinc "$file" -include-runtime -d "${name}.temp.jar" && \
    java -jar "${name}.temp.jar" && \
    rm "${name}.temp.jar"
}

# --- ALIASES ---
alias zsh-alt='ZDOTDIR=~/projects/bashed zsh'
alias reload='source ~/.zshrc && echo "Config reloaded! ♻️"'
unalias read 2>/dev/null # Fix for previous bad alias causing conflicts

# NvChad / Terminal Development Aliases

alias og='/usr/bin/vim'
alias vim='nvim'
alias vi='nvim'
alias v='nvim'
alias lg='lazygit'
alias nv='nvim'
alias nvconfig='nvim ~/.config/nvim/'
alias nvguide='nvim ~/.config/nvim/SETUP_GUIDE.md'
alias nvcheat='nvim ~/.config/nvim/CHEATSHEET.md'
alias home='cd ~'
alias c='clear'

# alias for echo as meow for cute shiii

alias meow=echo
alias bark=ls


# Better ls with colors (using eza)
alias ls='eza --icons'
alias ll='eza -lah --icons --git'
alias la='eza -A --icons'

# --- BAT (Better Cat) ---
alias cat='bat'

# --- MODERN CLI REPLACEMENTS ---
alias du='dust'
alias ps='procs'
alias sed='sd'

# --- TEALDEER (Faster TLDR) ---
# Ensure tldr uses a local cache
alias help='tldr'

# --- Additional Emacs/Readline Keybindings for Efficient Editing ---
# Cut/Delete
bindkey "^W" kill-word        # Cut word before cursor (Ctrl+W)
bindkey "^[d" kill-word      # Cut word after cursor (Alt+D or Esc+D)
bindkey "^U" kill-line       # Cut from cursor to beginning of line (Ctrl+U)
bindkey "^K" kill-line-to-end # Cut from cursor to end of line (Ctrl+K)
bindkey "^?" backward-delete-char # Delete word before cursor (Alt+Backspace or Ctrl+Backspace)

# Paste
bindkey "^Y" yank            # Paste (yank) last cut text (Ctrl+Y)

# Navigation & Transposition
bindkey "^[t" transpose-words # Swap current and previous words (Alt+T or Esc+T)
bindkey "^T" transpose-chars # Swap current and previous characters (Ctrl+T)

# --- Smart Browser Launcher (DRY: shared by brave/fox) ---
# Format: "keyword|alias;base_url;search_path"
_BROWSER_SITES=(
    "youtube|yt;https://www.youtube.com;/results?search_query="
    "github|gh;https://github.com;/search?q="
    "linkedin|li;https://www.linkedin.com;/search/results/all/?keywords="
    "christ|cu;https://christuniversity.in;"
    "hianime|hi;https://hianimez.is/home;https://hianimez.is/search?keyword="
    "monkeytype|mt;https://monkeytype.com;"
    "keybr|kb;https://www.keybr.com;"
    "greasyfork|gf;https://greasyfork.org;/scripts/search?q="
    "openjs;https://openuserjs.org;/?q="
    "classroom|cl;https://classroom.google.com;"
    "reddit|rd;https://www.reddit.com;/search/?q="
    "x|twitter;https://x.com;/search?q="
    "google|g;https://www.google.com;/search?q="
    "net;http://192.168.100.100:8090/;"
)

_open_browser() {
    local browser="$1"; shift

    if [[ -z "$1" ]]; then
        open -a "$browser"
        return
    fi

    local keyword="$1"; shift

    for site in "${_BROWSER_SITES[@]}"; do
        local aliases="${site%%;*}"
        local rest="${site#*;}"
        local base="${rest%%;*}"
        local search_path="${rest#*;}"

        if [[ "|${aliases}|" == *"|${keyword}|"* ]]; then
            if [[ -z "$@" ]]; then
                open -a "$browser" "$base"
            else
                local query=$(printf "%s+" "$@")
                query=${query%+}
                if [[ -n "$search_path" && "$search_path" != "$base" ]]; then
                    if [[ "$search_path" == /* ]]; then
                        open -a "$browser" "${base%/}${search_path}${query}"
                    else
                        open -a "$browser" "${search_path}${query}"
                    fi
                else
                    open -a "$browser" "${base}${query}"
                fi
            fi
            return
        fi
    done

    if [[ "$keyword" != http* ]]; then
        open -a "$browser" "https://$keyword"
    else
        open -a "$browser" "$keyword"
    fi
}

brave() { _open_browser "Brave Browser" "$@"; }

# yazi wrapper function
function y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
    
    # In Zellij, we must disable previews to prevent the 'j/k' jumping bug
    # caused by mangled terminal responses to image queries.
    if [[ -n "$ZELLIJ" ]]; then
        YAZI_CONFIG_HOME="$HOME/.config/yazi/zellij" command yazi "$@" --cwd-file="$tmp"
    else
        command yazi "$@" --cwd-file="$tmp"
    fi

    if [[ -f "$tmp" ]]; then
        local cwd
        IFS= read -r cwd < "$tmp"
        if [[ -n "$cwd" ]] && [[ "$cwd" != "$PWD" ]] && [[ -d "$cwd" ]]; then
            builtin cd -- "$cwd"
        fi
        rm -f -- "$tmp"
    fi
}

# Open PDF in Sioyek (New Window)
pdf() {
    /Applications/sioyek.app/Contents/MacOS/sioyek --new-window "$@" &> /dev/null &|
}

# --- Output Capturing Tools ---

# 1. Capture output of a single command to a file (stdout + stderr)
# Usage: cap <command>
# Example: cap ls -la
cap() {
    local timestamp=$(date +%Y%m%d_%H%M%S)
    local logfile="capture_${timestamp}.txt"
    echo "Saving output to $logfile ..."
    # Run command, pipe stdout & stderr to tee (writes to file and screen)
    "$@" |& tee "$logfile"
}

# 2. Record a full interactive session (e.g., vim, top, or multiple commands)
# Usage: rec
# Type 'exit' or Ctrl+D to stop recording.
alias rec='script recording_$(date +%Y%m%d_%H%M%S).txt'

# 3. Global Alias to copy output to clipboard (Pipe to C)
# Usage: echo "hello" C
# Shows output AND copies it to clipboard.
alias -g C='| tee /dev/tty | pbcopy'


# Video Players
alias play='mpv'
alias watch='open -a IINA'
alias book='open -a Books'
alias upscale='/Users/dan/projects/pythonVishal/Real-ESRGAN-0.3.0/realesrgan-ncnn-vulkan -m /Users/dan/projects/pythonVishal/Real-ESRGAN-0.3.0/models -n realesrgan-x4plus'
alias upscale-anime='/Users/dan/projects/pythonVishal/Real-ESRGAN-0.3.0/realesrgan-ncnn-vulkan -m /Users/dan/projects/pythonVishal/Real-ESRGAN-0.3.0/models -n realesrgan-x4plus-anime'
alias upscale-image='/Users/dan/projects/pythonVishal/Real-ESRGAN-0.3.0/realesrgan-ncnn-vulkan -m /Users/dan/projects/pythonVishal/Real-ESRGAN-0.3.0/models -n realesrgan-x4plus'
alias upscale-safe='/Users/dan/projects/pythonVishal/Real-ESRGAN-0.3.0/realesrgan-ncnn-vulkan -m /Users/dan/projects/pythonVishal/Real-ESRGAN-0.3.0/models -n realesrgan-x4plus -x'

# AI
alias ai='ollama run qwen2.5-coder:7b'

# Todoist Interactive
alias todo="todo-go list '(today | overdue | #Inbox | recurring)' | fzf --delimiter='\t' --with-nth=2 --header 'Inbox, Today & Recurring: Select to complete (ESC cancel)' --height 40% --reverse | awk '{print \$1}' | xargs todo-go close"

# --- Zellij Auto-Rename Tabs ---
function change_zellij_tab_title() {
  if [[ -n $ZELLIJ ]]; then
    command nohup zellij action rename-tab "$1" >/dev/null 2>&1 &!
  fi
}

function zellij_preexec() {
  local cmdline=$1
  # Truncate if longer than 15 chars
  if [[ ${#cmdline} -gt 15 ]]; then
    cmdline="${cmdline:0:15}..."
  fi
  change_zellij_tab_title "$cmdline"
}

function zellij_precmd() {
  # Set title to current dir name
  local current_dir=${PWD##*/}
  if [[ $PWD == $HOME ]]; then
    current_dir="~"
  fi
  change_zellij_tab_title "$current_dir"
}

if [[ -n $ZELLIJ ]]; then
  autoload -Uz add-zsh-hook
  add-zsh-hook preexec zellij_preexec
  add-zsh-hook precmd zellij_precmd
  # Initial title
  zellij_precmd
fi

# ntmux: Default to session 'dan', occasionally random
ntmux() {
  if [[ $# -gt 0 ]]; then
    # If arguments provided (e.g., ntmux ls), just run them
    zellij "$@"
    return
  fi

  # 1 in 10 chance to get a random funny name
  if [[ $((RANDOM % 10)) -eq 0 ]]; then
    echo "🎲 Lucky roll! Generating random name..."
    zellij
  else
    # 9 in 10 chance to use default 'dan'
    # 'attach -c' creates the session if it doesn't exist
    zellij attach -c "dan"
  fi
}

# --- FASTFETCH WRAPPER ---
fetch() {
    case "$1" in
        "go")
            fastfetch --logo ~/.config/fastfetch/logos/go.txt --logo-type file --logo-color-1 blue
            ;;
        "arch")
            fastfetch --logo arch
            ;;
        "random")
            local logos=("arch" "android" "apple" "windows" "linux" "ubuntu" "fedora" "debian")
            # Zsh arrays are 1-based, so add +1
            local random_index=$(( ($RANDOM % ${#logos[@]}) + 1 ))
            local random_logo=${logos[$random_index]}
            echo "Displaying logo: $random_logo"
            fastfetch --logo "$random_logo"
            ;;
        "")
            fastfetch
            ;;
        *)
            # Try to pass it directly to fastfetch
            fastfetch --logo "$1"
            ;;
    esac
}

# Neovim Playground Alias
alias nv-play="NVIM_APPNAME=nvim-playground $HOME/.local/share/bob/nightly/bin/nvim"

# Neovim Kickstart Alias
alias nv-kick="NVIM_APPNAME=nvim-kickstart nvim"
alias mini="NVIM_APPNAME=mini nvim"

# Cisco Packet Tracer
alias packettracer='open "/Applications/Cisco Packet Tracer 9.0.0/Cisco Packet Tracer 9.0.app"'


alias explain="$HOME/scripts/explain_tree.py"

# --- ANI-CLI CONFIGURATION ---
alias anim='ani-cli'                  # Short alias
alias anim-c='ani-cli -c'             # Continue watching from last history
alias anim-res='ani-cli -q 1080'      # Force 1080p quality
alias anim-dl='ani-cli -d'            # Download episode instead of playing

# Update ani-cli by pulling the latest code
anim-update() {
    (cd ~/.local/share/ani-cli && git pull && echo "✅ ani-cli updated successfully!")
}

# --- DISPLAY FILTERS ---
alias gray='toggle-gray'
alias sepia='shortcuts run "Sepia Mode"'

# --- SYSTEM EFFICIENCY ---

# 1. Update Everything (Homebrew, Pipx, Node, etc.)
up() {
    echo "🚀 Starting System-wide Update..."

    # Homebrew
    if command -v brew &> /dev/null; then
        echo "🍺 Updating Homebrew..."
        brew update && brew upgrade && brew cleanup
    fi

    # Node.js (npm)
    if command -v npm &> /dev/null; then
        echo "📦 Updating npm & global packages..."
        npm install -g npm
        npm update -g
    fi

    # pnpm
    if command -v pnpm &> /dev/null; then
        echo "📦 Updating pnpm..."
        pnpm self-update
    fi

    # Bun
    if command -v bun &> /dev/null; then
        echo "🍞 Updating Bun..."
        bun upgrade
    fi

    # Deno
    if command -v deno &> /dev/null; then
        echo "🦕 Updating Deno..."
        deno upgrade
    fi

    # Python (Pipx)
    if command -v pipx &> /dev/null; then
        echo "🐍 Updating Pipx packages..."
        pipx upgrade-all
    fi

    # Ruby (Gems)
    if command -v gem &> /dev/null; then
        echo "💎 Updating System Gems..."
        gem update --system
        gem update
        gem cleanup
    fi

    # Neovim (Bob)
    if command -v bob &> /dev/null; then
        echo "💤 Updating Neovim versions..."
        bob update --all
    fi

    # Tealdeer (tldr)
    if command -v tldr &> /dev/null; then
        echo "📖 Updating tldr pages..."
        tldr --update
    fi

    # Conda
    if command -v conda &> /dev/null; then
        echo "🧪 Updating Conda..."
        conda update -n base -c defaults conda --yes
    fi

    # ani-cli
    if [[ -d ~/.local/share/ani-cli ]]; then
        echo "📺 Updating ani-cli..."
        anim-update
    fi

    # Obsidian MOCs
    if [[ -d ~/notes ]]; then
        echo "📓 Updating Obsidian MOCs..."
        (cd ~/notes && python3 ~/dotfiles/scripts/auto_linker.py)
    fi

    # macOS App Store
    if command -v mas &> /dev/null; then
        echo "🍎 Updating Mac App Store apps..."
        mas upgrade
    fi

    # macOS System Updates (Check only)
    echo "🖥️ Checking for macOS updates..."
    softwareupdate -l

    echo "✅ System Updated!"
}

# 2. Deep Clean (Docker, Logs, Caches)
cleanup() {
    echo "🧹 Cleaning Homebrew Cache..."
    rm -rf "$(brew --cache)"
    
    echo "🧹 Cleaning Docker (Stopped containers, unused images)..."
    if command -v docker &> /dev/null; then
        docker system prune -f
    fi
    
    echo "🧹 Cleaning User Cache (Logs, Temp files)..."
    rm -rf ~/Library/Caches/Homebrew
    rm -rf ~/.npm/_cacache
    
    echo "✨ Disk space reclaimed!"
}

# 3. Fuzzy Find & Edit
# Usage: vf [search_term]
vf() {
    local file
    file=$(fzf --preview 'bat --style=numbers --color=always --line-range :500 {}')
    
    if [[ -n $file ]]; then
        $EDITOR "$file"
    fi
}

# Firefox — uses shared _open_browser
fox() { _open_browser "Firefox" "$@"; }

# Toggle macOS Dark Mode
toggle_dark() {
    osascript -e "tell application \"System Events\" to tell appearance preferences to set dark mode to not dark mode"
    if [[ "$(defaults read -g AppleInterfaceStyle 2>/dev/null)" == "Dark" ]]; then
        echo "🌙 Dark Mode enabled"
    else
        echo "☀️ Light Mode enabled"
    fi
}


alias dark="toggle_dark"

# function which puts the computer to sleep, closes the running docker containers and does some cleanup before sleeping 
alias goodnight='~/scripts/goodnight.sh'

# --- FILE ASSOCIATIONS (Explicit open command) ---
open() {
    if [[ $# -eq 0 ]]; then
        /usr/bin/open .
        return
    fi

    local target="$1"
    # Join arguments to handle unquoted filenames with spaces
    if [[ ! -f "$target" && $# -gt 1 && -f "$*" ]]; then
        target="$*"
    fi

    if [[ -f "$target" ]]; then
        local ext="${target##*.}"
        case "${ext:l}" in
            py|js|ts|java|cpp|c|go|rs|css|sh|nu|toml|yaml|yml|json|md|lua|rb|zig|swift|kt)
                nvim "$target"
                ;;
            pdf)
                # Force PDFs to open in Sioyek
                /usr/bin/open -a sioyek "$target"
                ;;
            html|htm)
                /usr/bin/open "$target"
                ;;
            mp4|mov|avi|mkv|mp3|wav|ogg|flac|webm|m4a)
                /usr/bin/open -a IINA "$target"
                ;;
            png|jpg|jpeg|gif|webp|bmp|tiff|svg)
                /usr/bin/open "$target"
                ;;
            docx|doc|xlsx|xls|pptx|ppt|csv|rtf)
                /usr/bin/open "$target"
                ;;
            epub)
                /usr/bin/open -a Books "$target"
                ;;
            *)
                /usr/bin/open "$target"
                ;;
        esac
        return 0
    else
        echo "zsh: no such file or directory: $target"
        return 1
    fi
}
