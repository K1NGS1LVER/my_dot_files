# ~/.bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# --- PATH ---
export PATH="$HOME/.local/bin:$HOME/.cargo/bin:/opt/homebrew/bin:$PATH"

# --- TOOLS ---
# Zoxide (Smart CD)
eval "$(zoxide init bash)"

# Atuin (History)
[[ -f /opt/homebrew/bin/atuin ]] && eval "$(atuin init bash)"

# --- ENV VARS ---
export JAVA_HOME=$(/usr/libexec/java_home)
export EDITOR="nvim"

# --- ALIASES ---
alias reload='source ~/.bashrc && echo "Config reloaded! ♻️"'
alias meow='echo'

# NvChad / Terminal Development Aliases
alias og='/usr/bin/vim'
alias lg='lazygit'
alias nv='nvim'
alias nvconfig='nvim ~/.config/nvim/'
alias nvguide='nvim ~/.config/nvim/SETUP_GUIDE.md'
alias nvcheat='nvim ~/.config/nvim/CHEATSHEET.md'

# --- FUNCTIONS ---

# Brave Browser Function (Handles URLs smart)
brave() {
    if [[ -z "$1" ]]; then
        open -a "Brave Browser"
        return
    fi

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

    for site in "${sites[@]}"; do
        local aliases="${site%%;*}"
        local rest="${site#*;}"
        local base="${rest%%;*}"
        local search_path="${rest#*;}"

        if [[ "|${aliases}|" == *"|${keyword}|"* ]]; then
            if [[ -z "$@" ]]; then
                open -a "Brave Browser" "$base"
            else
                local query=$(printf "%s+" "$@")
                query=${query%+}
                if [[ -n "$search_path" && "$search_path" != "$base" ]]; then
                    if [[ "$search_path" == /* ]]; then
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

    if [[ "$keyword" != http* ]]; then
        open -a "Brave Browser" "https://$keyword"
    else
        open -a "Brave Browser" "$keyword"
    fi
}

# yazi wrapper
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

# Open PDF in Sioyek
pdf() {
    /Applications/sioyek.app/Contents/MacOS/sioyek --new-window "$@" &> /dev/null &
}

# Capture output
cap() {
    local timestamp=$(date +%Y%m%d_%H%M%S)
    local logfile="capture_${timestamp}.txt"
    echo "Saving output to $logfile ..."
    "$@" | tee "$logfile" 2>&1
}

# Record session
alias rec='script recording_$(date +%Y%m%d_%H%M%S).txt'

# --- Zellij Auto-Rename (Simplified for Bash) ---
if [[ -n $ZELLIJ ]]; then
    function zellij_title() {
        local title="$1"
        command nohup zellij action rename-tab "$title" >/dev/null 2>&1
    }
    # Bash doesn't have preexec easily, so we just set it on prompt
    PROMPT_COMMAND='zellij_title "${PWD##*/}"'
fi

alias ls='eza --icons'
alias ll='eza -lah --icons --git'
alias la='eza -A --icons'
alias c='clear'
alias home='cd ~'

# Editor
alias vim='nvim'
alias vi='nvim'
alias v='nvim'

# --- KOTLIN ---
alias k='kotlin'
alias kc='kotlinc'

krun() {
    if [[ -z "$1" ]]; then
        echo "Usage: krun <file.kt>"
        return 1
    fi
    local file="$1"
    local name="${file%.*}"
    kotlinc "$file" -include-runtime -d "${name}.temp.jar" && \
    java -jar "${name}.temp.jar" && \
    rm "${name}.temp.jar"
}

# Git
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'

# Todo Tool (Go)
alias todo="todo-go list '(today | overdue | #Inbox | recurring)' | fzf --delimiter=$'\t' --with-nth=2 --header 'Inbox, Today & Recurring: Select to complete (ESC cancel)' --height 40% --reverse | awk '{print \$1}' | xargs todo-go close"

# The Fuck (Lazy Load)
fuck() {
    unset -f fuck
    eval $(thefuck --alias)
    fuck "$@"
}
# ntmux: Default to session 'dan', occasionally random
ntmux() {
  if [[ $# -gt 0 ]]; then
    zellij "$@"
    return
  fi

  if [[ $((RANDOM % 10)) -eq 0 ]]; then
    echo "🎲 Lucky roll! Generating random name..."
    zellij
  else
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
            local random_logo=${logos[$RANDOM % ${#logos[@]}]}
            echo "Displaying logo: $random_logo"
            fastfetch --logo $random_logo
            ;;
        "")
            fastfetch
            ;;
        *)
            fastfetch --logo "$1"
            ;;
    esac
}

# --- BASH COMPLETION ---
[[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && . "/opt/homebrew/etc/profile.d/bash_completion.sh"


# Neovim Playground Alias
alias nv-play="NVIM_APPNAME=nvim-playground nvim"

# Neovim Kickstart Alias
alias nv-kick="NVIM_APPNAME=nvim-kickstart nvim"

# Neovim Mini Alias
alias mini="NVIM_APPNAME=mini nvim"

# Cisco Packet Tracer
alias packettracer='open "/Applications/Cisco Packet Tracer 9.0.0/Cisco Packet Tracer 9.0.app"'
eval "$(starship init bash)"
alias explain="$HOME/scripts/explain_tree.py"
set -o vi

# --- FILE ASSOCIATIONS ---
command_not_found_handle() {
    if [[ -f "$1" ]]; then
        local ext="${1##*.}"
        case "${ext,,}" in
            py|js|ts|java|cpp|c|go|rs|html|css|sh)
                nvim "$1"
                ;;
            pdf)
                pdf "$1"
                ;;
            mp4|mov|avi|mkv|mp3|wav|ogg)
                open -a IINA "$1"
                ;;
            *)
                open "$1"
                ;;
        esac
    else
        echo "bash: $1: command not found"
        return 127
    fi
}
