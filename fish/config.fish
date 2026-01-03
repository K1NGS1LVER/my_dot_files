if status is-interactive
    # Commands to run in interactive sessions can go here

    # --- ALIASES ---
    alias ls='eza --icons'
    alias ll='eza -lah --icons --git'
    alias la='eza -A --icons'
    alias c='clear'
    alias home='cd ~'
    
    # Git
    alias gs='git status'
    alias ga='git add'
    alias gc='git commit'
    alias gp='git push'

    # Editor
    alias vim='nvim'
    alias vi='nvim'
    alias v='nvim'

    # --- TOOLS ---
    # Initialize Zoxide (smarter cd)
    zoxide init fish | source

    # Initialize Atuin (Magic History)
    if test -f /opt/homebrew/bin/atuin
        atuin init fish | source
    end

    # Starship Prompt (Highly recommended for cross-shell unity)
    # starship init fish | source

    # --- TODO TOOL ---
    # Using your new Go binary
    alias todo="todo-go list '(today | overdue | #Inbox | recurring)' | fzf --delimiter='\t' --with-nth=2 --header 'Inbox, Today & Recurring: Select to complete (ESC cancel)' --height 40% --reverse | awk '{print \$1}' | xargs todo-go close"

    # Fix PATH to include local bin and cargo
    fish_add_path $HOME/.local/bin
    fish_add_path $HOME/.cargo/bin
    fish_add_path /opt/homebrew/bin
end
\n# The Fuck\nthefuck --alias | source
function ntmux
    if count $argv > /dev/null
        zellij $argv
    else
        # Generate random number 1-10
        set -l roll (random 1 10)
        if test $roll -eq 1
            echo "🎲 Lucky roll! Generating random name..."
            zellij
        else
            zellij attach -c "dan"
        end
    end
end
