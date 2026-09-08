# multiplexer.nu — Zellij hooks + ttmux/ntmux/tkill session managers

def ntmux [...args: string] {
    if ($args | is-empty) {
        ^zellij attach -c "dan"
    } else {
        ^zellij ...$args
    }
}
