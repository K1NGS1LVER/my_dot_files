if status is-interactive
    # --- NAVIGATION ---
    alias ..='cd ..'
    alias ...='cd ../..'
    alias ....='cd ../../..'
    alias home='cd ~'
    alias c='clear'

    # --- FILE LISTING (eza) ---
    alias ls='eza --icons'
    alias ll='eza -lah --icons --git'
    alias la='eza -A --icons'

    # --- MODERN CLI REPLACEMENTS ---
    alias cat='bat'
    alias help='tldr'

    # --- GIT ---
    alias g='git'
    alias gs='git status'
    alias gd='git diff'
    alias gc='git commit'
    alias gp='git push'
    alias lg='lazygit'

    # --- EDITOR & NOTES ---
    alias v='nvim'
    alias vim='nvim'
    alias nvconfig='nvim ~/.config/nvim/'
    alias notes='clin --vault ~/notes'
    alias mini='NVIM_APPNAME=mini nvim'

    # --- MEDIA & SYSTEM ---
    alias anim='ani-cli'
    alias gray='toggle-gray'
    alias dark='toggle_dark'
    alias reload='source ~/.config/fish/config.fish; and echo "Config reloaded! ♻️"'
    alias explain='/Users/dan/dotfiles/scripts/explain_tree.py'
    alias ts='/Users/dan/dotfiles/scripts/tmux-sessionizer'
    alias tms='/Users/dan/dotfiles/scripts/tmux-sessionizer'
    alias deploy='/Users/dan/dotfiles/scripts/deploy'
    alias doctor='/Users/dan/dotfiles/scripts/doctor'

    # --- ENV VARS ---
    set -gx EDITOR nvim
    if test -x /usr/libexec/java_home
        set -gx JAVA_HOME (/usr/libexec/java_home 2>/dev/null)
    end

    # Fix PATH
    fish_add_path $HOME/dotfiles/scripts
    fish_add_path $HOME/.local/bin
    fish_add_path $HOME/.cargo/bin
    fish_add_path /opt/homebrew/bin

    # --- TOOLS ---
    type -q zoxide; and zoxide init fish | source
    type -q fzf; and fzf --fish | source
    type -q starship; and starship init fish | source

    # --- PDF (Sioyek) ---
    function pdf
        /Applications/sioyek.app/Contents/MacOS/sioyek --new-window $argv > /dev/null 2>&1 &
        disown
    end

    # --- YAZI WRAPPER ---
    function y
        set tmp (mktemp -t "yazi-cwd.XXXXXX")
        command yazi $argv --cwd-file="$tmp"
        if test -f "$tmp"
            set cwd (cat "$tmp")
            if test -n "$cwd" -a "$cwd" != "$PWD" -a -d "$cwd"
                builtin cd -- "$cwd"
            end
            rm -f -- "$tmp"
        end
    end

    # --- ZELLIJ AUTO-RENAME ---
    if test -n "$ZELLIJ"
        function zellij_rename --on-event fish_prompt
            command nohup zellij action rename-tab (prompt_pwd) >/dev/null 2>&1
        end
    end

    # --- ZELLIJ ATTACH HELPER ---
    function ntmux
        if count $argv > /dev/null
            zellij $argv
        else
            zellij attach -c "dan" 2>/dev/null; or zellij
        end
    end

    # --- FILE ASSOCIATIONS ---
    function fish_command_not_found
        set -l cmd $argv[1]
        if test -f "$cmd"
            set -l ext (string split -r -m1 . $cmd)[2]
            switch (string lower "$ext")
                case py js ts java cpp c go rs html css sh toml yaml yml json md lua
                    nvim $cmd
                case pdf
                    pdf $cmd
                case mp4 mov avi mkv mp3 wav ogg flac
                    open -a IINA $cmd
                case '*'
                    open $cmd
            end
        else
            __fish_default_command_not_found_handler $argv
        end
    end
end

# Airflow Assignment Environment Configuration
set -gx AIRFLOW_HOME "/Users/dan/projects/data_eng_assignments/data_eng_27_june/airflow_home"
