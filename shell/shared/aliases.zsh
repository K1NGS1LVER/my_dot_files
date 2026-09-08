# Shared aliases — Zsh syntax
# Identical command mappings to aliases.nu — do not edit one without the other.
# Shell-native commands (reload, ls built-ins) are intentionally asymmetric.

# --- Navigation ---
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias home='cd ~'
alias c='clear'

# --- Editor ---
alias v='nvim'
alias vim='nvim'
alias nvconfig='nvim ~/.config/nvim/'
alias notes='clin --vault ~/notes'
alias mini='NVIM_APPNAME=mini nvim'

# --- File Listing (eza) ---
alias ls='eza --icons'
alias ll='eza -lah --icons --git'
alias la='eza -A --icons'

# --- Modern CLI Replacements ---
alias cat='bat'
alias help='tldr'

# --- Git ---
alias g='git'
alias gs='git status'
alias gd='git diff'
alias gc='git commit'
alias gp='git push'
alias lg='lazygit'

# --- Anime & Media ---
alias anim='ani-cli'

# --- AI ---
alias ai='cd ~/models && /Users/dan/.local/bin/llama-cli -hf Qwen/Qwen2.5-Coder-7B-Instruct-GGUF:Q4_K_M --flash-attn on --n-gpu-layers 99 --no-mmap --mlock -c 8192 -p "Offline reference assistant. Answer directly, no greetings or filler. If unsure, say so instead of guessing. Be concise; expand only if the question needs depth."'

# --- Display & System ---
alias gray='toggle-gray'
alias dark='toggle_dark'
theme-switch() {
    switch-theme "$@"
    if [ -f "$HOME/dotfiles/shell/shared/active-theme.zsh" ]; then
        source "$HOME/dotfiles/shell/shared/active-theme.zsh"
    fi
}
alias goodnight='~/scripts/goodnight.sh'

# --- Dotfiles & Tools ---
alias deploy='/Users/dan/dotfiles/scripts/deploy'
alias doctor='/Users/dan/dotfiles/scripts/doctor'
alias dotfiles-deploy='/Users/dan/dotfiles/scripts/deploy'
alias dotfiles-doctor='/Users/dan/dotfiles/scripts/doctor'
alias update-brew='/Users/dan/dotfiles/scripts/update-brew'
alias tmux-sessionizer='/Users/dan/dotfiles/scripts/tmux-sessionizer'
alias explain='/Users/dan/dotfiles/scripts/explain_tree.py'
if [[ -n "$ZSH_VERSION" ]]; then
    alias -g C='| tee /dev/tty | pbcopy'
else
    alias C='pbcopy'
fi
