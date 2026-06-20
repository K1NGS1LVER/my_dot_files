# welcome.nu — Random startup greeting

def --env welcome-message [] {
    let choice = (random int 0..2)
    if $choice == 0 {
        if (which pokemon-colorscripts | is-not-empty) {
            ^pokemon-colorscripts -r
        }
    } else if $choice == 1 {
        let scripts_dir = "/opt/shell-color-scripts/colorscripts"
        if ($scripts_dir | path exists) {
            let scripts = (ls $scripts_dir | get name)
            if ($scripts | is-not-empty) {
                let script = ($scripts | shuffle | first 1 | get 0)
                bash $script
            }
        }
    } else {
        if (which fortune | is-not-empty) and (which cowsay | is-not-empty) {
            ^fortune | ^cowsay -f small
        }
    }
}
