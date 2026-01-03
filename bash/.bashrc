# ~/.bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# --- PATH ---
export PATH="$HOME/.local/bin:$HOME/.cargo/bin:/opt/homebrew/bin:$PATH"

# --- TOOLS ---
# Starship (Prompt)
# eval "$(starship init bash)"

# Zoxide (Smart CD)
eval "$(zoxide init bash)"

# Atuin (History)
[[ -f /opt/homebrew/bin/atuin ]] && eval "$(atuin init bash)"

# --- ALIASES ---
alias ls='eza --icons'
alias ll='eza -lah --icons --git'
alias la='eza -A --icons'
alias c='clear'
alias home='cd ~'

# Editor
alias vim='nvim'
alias vi='nvim'
alias v='nvim'

# Git
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'

# Todo Tool (Go)
alias todo="todo-go list '(today | overdue | #Inbox | recurring)' | fzf --delimiter=$'\t' --with-nth=2 --header 'Inbox, Today & Recurring: Select to complete (ESC cancel)' --height 40% --reverse | awk '{print \$1}' | xargs todo-go close"
\n# The Fuck\neval $(thefuck --alias)
alias ntmux='zellij'
