# yazi.zsh — Yazi file manager wrappers with CWD sync

_run_yazi() {
    # In Zellij, force documented fallback adapter to prevent
    # terminal graphics escape sequences from leaking into stdin.
    if [[ -n "$ZELLIJ" ]]; then
        TERM="xterm-kitty" YAZI_CONFIG_HOME="$HOME/.config/yazi/zellij" command yazi "$@"
    else
        command yazi "$@"
    fi
}

yazi() {
    _run_yazi "$@"
}

y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
    _run_yazi "$@" --cwd-file="$tmp"

    if [[ -f "$tmp" ]]; then
        local cwd
        IFS= read -r cwd < "$tmp"
        if [[ -n "$cwd" ]] && [[ "$cwd" != "$PWD" ]] && [[ -d "$cwd" ]]; then
            builtin cd -- "$cwd"
        fi
        rm -f -- "$tmp"
    fi
}
