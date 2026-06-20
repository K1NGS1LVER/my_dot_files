# multiplexer.nu — Zellij hooks + ttmux/ntmux/tkill session managers

alias ks = kitty --session ~/.config/kitty/session.conf
alias t = ttmux
alias tk = tkill

# ttmux: abduco wrapper, defaults to "main" session
def --wrapped ttmux [...args: string] {
    let shell = "nu"
    let default_key = "^a"

    if ($args | is-empty) {
        ^abduco -e $default_key -A main $shell
    } else if ($args | length) == 1 {
        let name = ($args | first)
        if ($name | str starts-with "-") {
            ^abduco ...$args
        } else {
            ^abduco -e $default_key -A $name $shell
        }
    } else {
        ^abduco ...$args
    }
}

def ntmux [...args: string] {
    if ($args | is-empty) {
        ^zellij attach -c "dan"
    } else {
        ^zellij ...$args
    }
}

# Kill an abduco session by name
def tkill [name: string] {
    let sessions = (ps -l | where command =~ "abduco" | where command =~ $name)

    if ($sessions | is-empty) {
        print $"No abduco session found matching: ($name)"
    } else {
        $sessions | each { |it|
            kill $it.pid
            print $"Terminated abduco session: ($name) \(PID: ($it.pid)\)"
        }
    }
}
