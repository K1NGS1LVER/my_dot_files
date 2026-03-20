# ~/.bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# --- PATH ---
export PATH="$HOME/dotfiles/scripts:/opt/homebrew/bin:/opt/homebrew/sbin:$HOME/.local/bin:$HOME/.cargo/bin:$HOME/Library/pnpm:$PATH"

# --- LOCALE ---
export LC_ALL="en_IN.UTF-8"
export LANG="en_IN.UTF-8"

# --- TOOLS ---
command -v zoxide >/dev/null 2>&1 && eval "$(zoxide init bash)"
command -v atuin >/dev/null 2>&1 && eval "$(atuin init bash)"

# --- ENV VARS ---
export EDITOR="nvim"
export JAVA_HOME=$(/usr/libexec/java_home 2>/dev/null)
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export BAT_THEME="Catppuccin Macchiato"

# --- ALIASES ---
alias reload='source ~/.bashrc && echo "Config reloaded! ♻️"'
alias c='clear'
alias home='cd ~'
alias n='nvim'
alias v='nvim'
alias vi='nvim'
alias vim='nvim'
alias nv='nvim'
alias lg='lazygit'

# Better ls with colors (using eza)
alias ls='eza --icons'
alias ll='eza -lah --icons --git'
alias la='eza -A --icons'

# Modern CLI Replacements
alias cat='bat'
alias du='dust'
alias ps='procs'
alias sed='sd'
alias help='tldr'

# --- FUNCTIONS ---
y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
    yazi "$@" --cwd-file="$tmp"
    if [[ -f "$tmp" ]]; then
        local cwd
        cwd=$(cat "$tmp")
        if [[ -n "$cwd" ]] && [[ "$cwd" != "$PWD" ]] && [[ -d "$cwd" ]]; then
            builtin cd -- "$cwd"
        fi
        rm -f -- "$tmp"
    fi
}

ntmux() {
  if [[ $# -gt 0 ]]; then
    zellij "$@"
    return
  fi
  zellij attach -c "dan" 2>/dev/null || zellij
}

# --- BASH COMPLETION ---
[[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && . "/opt/homebrew/etc/profile.d/bash_completion.sh"

# --- OPTIONS ---
set -o vi
alias explain="$HOME/scripts/explain_tree.py"

# --- STARSHIP PROMPT ---
export STARSHIP_CONFIG="$HOME/.config/starship.toml"
if [[ -x /opt/homebrew/bin/starship ]]; then
    # Start with a sane default PS1
    PS1='[\u@\h \W]\$ '
    # Initialize Starship
    eval "$(/opt/homebrew/bin/starship init bash)"
    # If Starship failed to set a prompt (empty PS1), revert to a safe one
    [[ -z "$PS1" ]] && PS1='[\u@\h \W]\$ '
fi

# --- FILE ASSOCIATIONS ---
command_not_found_handle() {
    if [[ -f "$1" ]]; then
        local ext="${1##*.}"
        case "${ext,,}" in
            py|js|ts|java|cpp|c|go|rs|sh) nvim "$1" ;;
            pdf) open -a Sioyek "$1" ;;
            mp4|mov|mkv|mp3) open -a IINA "$1" ;;
            *) open "$1" ;;
        esac
    else
        echo "bash: $1: command not found"
        return 127
    fi
}
