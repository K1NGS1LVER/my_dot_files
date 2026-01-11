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

    # --- KOTLIN ---
    alias k='kotlin'
    alias kc='kotlinc'
    
    function krun
        if test (count $argv) -eq 0
            echo "Usage: krun <file.kt>"
            return 1
        end
        set -l file $argv[1]
        set -l name (string replace -r '\.kt$' '' $file)
        kotlinc $file -include-runtime -d "$name.temp.jar"
        and java -jar "$name.temp.jar"
        and rm "$name.temp.jar"
    end

    # --- ENV VARS ---
    set -gx JAVA_HOME (/usr/libexec/java_home)
    set -gx EDITOR nvim

    # --- ALIASES ---
    alias reload='source ~/.config/fish/config.fish; and echo "Config reloaded! ♻️"'
    alias meow='echo'
    
    # NvChad / Dev
    alias og='/usr/bin/vim'
    alias lg='lazygit'
    alias nv='nvim'
    alias nvconfig='nvim ~/.config/nvim/'
    alias nvguide='nvim ~/.config/nvim/SETUP_GUIDE.md'
    alias nvcheat='nvim ~/.config/nvim/CHEATSHEET.md'
    
    # Recording
    alias rec='script recording_(date +%Y%m%d_%H%M%S).txt'

    # --- FUNCTIONS ---
    
    # PDF (Sioyek)
    function pdf
        /Applications/sioyek.app/Contents/MacOS/sioyek --new-window $argv > /dev/null 2>&1 &
        disown
    end

    # Yazi Wrapper
    function y
        set tmp (mktemp -t "yazi-cwd.XXXXXX")
        yazi $argv --cwd-file="$tmp"
        if test -f "$tmp"
            set cwd (cat "$tmp")
            if test -n "$cwd" -a "$cwd" != "$PWD" -a -d "$cwd"
                builtin cd -- "$cwd"
            end
            rm -f -- "$tmp"
        end
    end

    # Brave Browser Smart Search
    function brave
        if test (count $argv) -eq 0
            open -a "Brave Browser"
            return
        end

        set -l sites \
            "youtube|yt;https://www.youtube.com;/results?search_query=" \
            "github|gh;https://github.com;/search?q=" \
            "linkedin|li;https://www.linkedin.com;/search/results/all/?keywords=" \
            "christ|cu;https://christuniversity.in;" \
            "hianime|hi;https://hianimez.is/home;https://hianimez.is/search?keyword=" \
            "monkeytype|mt;https://monkeytype.com;" \
            "keybr|kb;https://www.keybr.com;" \
            "greasyfork|gf;https://greasyfork.org;/scripts/search?q=" \
            "openjs;https://openuserjs.org;/?q=" \
            "classroom|cl;https://classroom.google.com;" \
            "reddit|rd;https://www.reddit.com;/search/?q=" \
            "x|twitter;https://x.com;/search?q=" \
            "google|g;https://www.google.com;/search?q=" \
            "net;http://192.168.100.100:8090/;"

        set -l keyword $argv[1]
        set -l query_args $argv[2..-1]
        
        for site in $sites
            set -l parts (string split ";" $site)
            set -l aliases (string split "|" $parts[1])
            set -l base $parts[2]
            set -l search_path $parts[3]

            if contains -- $keyword $aliases
                if test (count $query_args) -eq 0
                    open -a "Brave Browser" "$base"
                else
                    set -l query (string join "+" $query_args)
                    
                    if test -n "$search_path" -a "$search_path" != "$base"
                        if string match -q "/*" "$search_path"
                             open -a "Brave Browser" "$base$search_path$query"
                        else
                             open -a "Brave Browser" "$search_path$query"
                        end
                    else
                        open -a "Brave Browser" "$base$query"
                    end
                end
                return
            end
        end

        # Default
        if string match -q "http*" $keyword
             open -a "Brave Browser" "$keyword"
        else
             open -a "Brave Browser" "https://$keyword"
        end
    end

    # --- Zellij Auto-Rename ---
    if test -n "$ZELLIJ"
        function zellij_rename --on-event fish_prompt
            command nohup zellij action rename-tab (prompt_pwd) >/dev/null 2>&1
        end
    end

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
# The Fuck (Lazy Load)
function fuck
    functions --erase fuck
    thefuck --alias | source
    fuck $argv
end
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

# --- FASTFETCH WRAPPER ---
function fetch
    if test (count $argv) -eq 0
        fastfetch
        return
    end

    switch $argv[1]
        case "go"
            fastfetch --logo ~/.config/fastfetch/logos/go.txt --logo-type file --logo-color-1 blue
        case "arch"
            fastfetch --logo arch
        case "random"
            set -l logos arch android apple windows linux ubuntu fedora debian
            set -l random_logo (random choice $logos)
            echo "Displaying logo: $random_logo"
            fastfetch --logo $random_logo
        case "*"
            fastfetch --logo $argv[1]
    end
end
