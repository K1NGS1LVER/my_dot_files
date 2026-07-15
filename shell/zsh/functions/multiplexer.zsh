# multiplexer.zsh — Zellij tab rename hooks + ntmux session manager

# Zellij auto-rename tabs to running command / current directory
change_zellij_tab_title() {
    if [[ -n $ZELLIJ ]]; then
        command nohup zellij action rename-tab "$1" >/dev/null 2>&1 &!
    fi
}

zellij_preexec() {
    local cmdline=$1
    if [[ ${#cmdline} -gt 15 ]]; then
        cmdline="${cmdline:0:15}..."
    fi
    change_zellij_tab_title "$cmdline"
}

zellij_precmd() {
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
    zellij_precmd
fi

# ttmux/tkill: abduco session manager (parity port of shell/nushell/modules/multiplexer.nu)
alias t='ttmux'
alias tk='tkill'

# ttmux: abduco wrapper, defaults to "main" session
ttmux() {
    local default_key='^a'
    if [[ $# -eq 0 ]]; then
        abduco -e "$default_key" -A main zsh
    elif [[ $# -eq 1 && "$1" != -* ]]; then
        abduco -e "$default_key" -A "$1" zsh
    else
        abduco "$@"
    fi
}

# Kill an abduco session by name
tkill() {
    local name="$1"
    local -a pids
    pids=("${(@f)$(ps -eo pid,command | grep abduco | grep "$name" | grep -v grep | awk '{print $1}')}")
    if [[ ${#pids[@]} -eq 0 || -z "${pids[1]}" ]]; then
        echo "No abduco session found matching: $name"
    else
        for pid in "${pids[@]}"; do
            kill "$pid"
            echo "Terminated abduco session: $name (PID: $pid)"
        done
    fi
}

# ntmux: Default to session 'dan', 1/10 chance random name
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
