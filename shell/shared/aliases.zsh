# Shared aliases — Zsh syntax
# Identical command mappings to aliases.nu — do not edit one without the other.
# Shell-native commands (reload, ls built-ins) are intentionally asymmetric.

# --- Editor ---
alias vim='nvim'
alias vi='nvim'
alias v='nvim'
alias nv='nvim'
alias og='/usr/bin/vim'
alias nvconfig='nvim ~/.config/nvim/'
alias nvguide='nvim ~/dotfiles/docs/SETUP_GUIDE.md'
alias nvcheat='nvim ~/dotfiles/docs/CHEATSHEET.md'
alias notes='clin --vault ~/notes'

# --- Neovim Profiles ---
alias nv-play='NVIM_APPNAME=nvim-playground $HOME/.local/share/bob/nightly/bin/nvim'
alias nv-kick='NVIM_APPNAME=nvim-kickstart nvim'
alias mini='NVIM_APPNAME=mini nvim'

# --- Navigation ---
alias home='cd ~'
alias c='clear'

# --- File Listing (eza) ---
alias ls='eza --icons'
alias ll='eza -lah --icons --git'
alias la='eza -A --icons'
alias els='eza --icons'

# --- Modern CLI Replacements ---
alias cat='bat'
alias help='tldr'
alias sed='sd'
alias du='dust'
alias ps='procs'

# --- Git ---
alias g='git'
alias gs='git status'
alias gd='git diff'
alias gc='git commit'
alias gp='git push'
alias lg='lazygit'

# --- Kotlin ---
alias k='kotlin'
alias kc='kotlinc'

# --- Media & Apps ---
alias play='mpv'
alias watch='open -a IINA'
alias book='open -a Books'
alias meow='echo'
alias bark='ls'

# --- Anime ---
alias anim='ani-cli'
alias anim-c='ani-cli -c'
alias anim-res='ani-cli -q 1080'
alias anim-dl='ani-cli -d'

# --- AI ---
alias ai='ollama run qwen2.5-coder:3b'

# --- Display & System ---
alias gray='toggle-gray'
alias sepia='shortcuts run "Sepia Mode"'
alias dark='toggle_dark'
theme-switch() {
    /Users/dan/dotfiles/scripts/switch-theme "$@"
    if [ -f "$HOME/dotfiles/shell/shared/active-theme.zsh" ]; then
        source "$HOME/dotfiles/shell/shared/active-theme.zsh"
    fi
}
alias goodnight='~/scripts/goodnight.sh'
alias packettracer='open "/Applications/Cisco Packet Tracer 9.0.0/Cisco Packet Tracer 9.0.app"'

# --- tmux ---
alias tmux-sessionizer='/Users/dan/dotfiles/scripts/tmux-sessionizer'

# --- Dotfiles maintenance ---
alias dotfiles-deploy='/Users/dan/dotfiles/scripts/deploy'
alias dotfiles-doctor='/Users/dan/dotfiles/scripts/doctor'
alias update-nvim-plugins='/Users/dan/dotfiles/scripts/update-nvim-plugins'
alias update-notebook-env='/Users/dan/dotfiles/scripts/update-notebook-env'
alias update-brew='/Users/dan/dotfiles/scripts/update-brew'

# --- Misc ---
alias explain='$HOME/scripts/explain_tree.py'
alias rec='script recording_$(date +%Y%m%d_%H%M%S).txt'
alias -g C='| tee /dev/tty | pbcopy'
