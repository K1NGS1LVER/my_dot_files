# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# --- THEME SELECTION ---
# "agnoster" is a great theme that shows git status and path clearly.
# Note: Requires a Powerline font installed in your terminal.
# If icons look weird, switch this back to "robbyrussell".
ZSH_THEME="powerlevel10k/powerlevel10k"

# this is to stop the prompts pop up when the terminal starts
# POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true

# Set list of themes to pick from when loading at random
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
 ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
 COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
plugins=(
    git
    zsh-autosuggestions  
    zsh-syntax-highlighting
    # history-substring-search # (Optional: allows typing part of a command and hitting up arrow)
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set Java environment variables
export JAVA_HOME=$(/usr/libexec/java_home)
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"

# --- ALIASES ---
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

# Better ls with colors (using eza)
alias ls='eza --icons'
alias ll='eza -lah --icons --git'
alias la='eza -A --icons'

# Initialize zoxide (smarter cd)
eval "$(zoxide init zsh)"
eval "$(zoxide init zsh --cmd cd)"

# TypeScript Runner (Fixes NodeNext/ModuleResolution errors)
alias tsr='ts-node -O "{\"module\":\"commonjs\"}"'

# Ebook Reader
alias book='open -a Books'

# Quick directory navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias home='cd ~'
alias c='clear'

# Git shortcuts (complement to lazygit)
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline --graph --decorate'

# alias for fastfetch
alias fetch='fastfetch'

# --- KEY BINDINGS (Shortcuts) ---
# This fixes keys to work like standard text editors

# Use Emacs keybindings by default (Ctrl+A start, Ctrl+E end)
bindkey -e 

# Make keys work for MacOS/Terminals that send specific codes
bindkey "^[[1;3C" forward-word      # Option+Right Arrow (Move forward a word)
bindkey "^[[1;3D" backward-word     # Option+Left Arrow (Move back a word)
bindkey "^[[1;5C" forward-word      # Ctrl+Right Arrow
bindkey "^[[1;5D" backward-word     # Ctrl+Left Arrow
bindkey "^[[H" beginning-of-line    # Home Key
bindkey "^[[F" end-of-line          # End Key
bindkey "^A" beginning-of-line      # Ctrl+A
bindkey "^E" end-of-line            # Ctrl+E

# --- FZF (Fuzzy Search) ---
# Setup fzf key bindings and fuzzy completion
# source <(fzf --zsh) # Commented out to prevent conflict with Atuin Ctrl+R

# --- ATUIN (Advanced History) ---
# Start the Atuin shell integration
# This should be loaded at the end of your shell config.
[[ -s /opt/homebrew/opt/atuin/bin/atuin.sh ]] && source /opt/homebrew/opt/atuin/bin/atuin.sh

# --- BAT (Better Cat) ---
alias cat='bat'
# Colorize MAN pages using bat
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export BAT_THEME="Catppuccin Macchiato"

# --- TLDR ---
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

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


export PATH="$HOME/.cargo/bin:$PATH"


# --- Lynx Browser Theme ---
export LYNX_CFG=~/.lynx.cfg
export LYNX_LSS=~/.lynx.lss


# Brave Browser Function (Handles URLs smart)
brave() {
    # 1. Handle empty arguments
    if [[ -z "$1" ]]; then
        open -a "Brave Browser"
        return
    fi

    # 2. Site definitions
    # Format: "keyword|alias;base_url;search_path"
    # We use ';' as a delimiter because it is not part of the standard URL protocol prefix (like 'https:')
    local sites=(
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

    local keyword="$1"
    shift

    # 3. Iterate and match
    for site in "${sites[@]}"; do
        # Parse fields using ';' delimiter
        local aliases="${site%%;*}"   # Everything before the first ';'
        local rest="${site#*;}"       # Everything after the first ';'
        local base="${rest%%;*}"      # Everything before the next ';'
        local search_path="${rest#*;}" # Everything after that ';' (optional)

        # Check if keyword matches any alias (surrounded by pipes)
        if [[ "|${aliases}|" == *"|${keyword}|"* ]]; then
            if [[ -z "$@" ]]; then
                # No query provided -> Open Base URL
                open -a "Brave Browser" "$base"
            else
                # Query provided -> Construct Search URL
                local query=$(printf "%s+" "$@")
                query=${query%+} # Remove trailing '+'
                
                # Use search_path if available, otherwise append query to base (fallback)
                if [[ -n "$search_path" && "$search_path" != "$base" ]]; then
                    # Check if search_path is relative (starts with /)
                    if [[ "$search_path" == /* ]]; then
                         # Remove trailing slash from base if present to avoid double slashes
                        open -a "Brave Browser" "${base%/}${search_path}${query}"
                    else
                        open -a "Brave Browser" "${search_path}${query}"
                    fi
                else
                    open -a "Brave Browser" "${base}${query}"
                fi
            fi
            return
        fi
    done

    # 4. Default Fallback: Treat as direct URL
    if [[ "$keyword" != http* ]]; then
        open -a "Brave Browser" "https://$keyword"
    else
        open -a "Brave Browser" "$keyword"
    fi
}

# yazi wrapper fucntion 
export EDITOR="nvim"
function y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
    yazi "$@" --cwd-file="$tmp"
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


# Created by `pipx` on 2025-12-26 19:45:40
export PATH="$PATH:/Users/dan/.local/bin"

# Add Mason binaries to PATH (Neovim tools)
export PATH="$HOME/.local/share/nvim/mason/bin:$PATH"

# Video Players
alias play='mpv'
alias watch='open -a IINA'
alias book='open -a Books'
alias upscale='/Users/dan/projects/pythonVishal/Real-ESRGAN-0.3.0/realesrgan-ncnn-vulkan -m /Users/dan/projects/pythonVishal/Real-ESRGAN-0.3.0/models'

# Todoist Interactive
alias todo="todoist list | fzf --header 'Select task to complete (ESC to cancel)' --height 40% --reverse | awk '{print \$1}' | xargs -r todoist close"
