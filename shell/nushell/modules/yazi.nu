# yazi.nu — Yazi file manager wrappers with CWD sync

def --env --wrapped yazi [...args] {
    if ("ZELLIJ" in $env) {
        let zellij_conf = ([$env.HOME ".config" "yazi" "zellij"] | path join)
        $env.YAZI_CONFIG_HOME = $zellij_conf
        $env.TERM = "xterm-kitty"
        ^yazi ...$args
    } else {
        ^yazi ...$args
    }
}

def --env --wrapped y [...args] {
    let tmp = (^mktemp -t "yazi-cwd" | str trim)

    yazi ...$args --cwd-file $tmp

    if ($tmp | path exists) {
        let cwd = (open --raw $tmp | str trim)
        if ($cwd | is-not-empty) and ($cwd != $env.PWD) {
            cd $cwd
        }
        rm -f $tmp
    }
}
