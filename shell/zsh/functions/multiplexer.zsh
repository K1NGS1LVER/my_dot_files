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
