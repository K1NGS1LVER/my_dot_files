# welcome.nu — Random startup greeting

def --env welcome-message [] {
    let choice = (random int 0..2)
    if $choice == 0 {
        if (which pokemon-colorscripts | is-not-empty) {
            ^pokemon-colorscripts -r
        } else if ($"/opt/shell-color-scripts/colorscripts" | path exists) {
            let scripts = (ls /opt/shell-color-scripts/colorscripts | where type == file | get name | where {|x| ($x | path basename) != "pacman-large" and ($x | path basename) != "pacman-large-multiple"} )
            if ($scripts | is-not-empty) {
                let script = ($scripts | shuffle | first 1 | get 0)
                bash $script
            } else if (which fortune | is-not-empty) and (which cowsay | is-not-empty) {
                ^fortune | ^cowsay -f small
            }
        } else if (which fortune | is-not-empty) and (which cowsay | is-not-empty) {
            ^fortune | ^cowsay -f small
        }
    } else if $choice == 1 {
        let scripts_dir = "/opt/shell-color-scripts/colorscripts"
        if ($scripts_dir | path exists) {
            let scripts = (ls $scripts_dir | where type == file | get name | where {|x| ($x | path basename) != "pacman-large" and ($x | path basename) != "pacman-large-multiple"} )
            if ($scripts | is-not-empty) {
                let script = ($scripts | shuffle | first 1 | get 0)
                bash $script
            } else if (which pokemon-colorscripts | is-not-empty) {
                ^pokemon-colorscripts -r
            } else if (which fortune | is-not-empty) and (which cowsay | is-not-empty) {
                ^fortune | ^cowsay -f small
            }
        } else if (which pokemon-colorscripts | is-not-empty) {
            ^pokemon-colorscripts -r
        } else if (which fortune | is-not-empty) and (which cowsay | is-not-empty) {
            ^fortune | ^cowsay -f small
        }
    } else {
        if (which fortune | is-not-empty) and (which cowsay | is-not-empty) {
            ^fortune | ^cowsay -f small
        } else if (which pokemon-colorscripts | is-not-empty) {
            ^pokemon-colorscripts -r
        } else if ($"/opt/shell-color-scripts/colorscripts" | path exists) {
            let scripts = (ls /opt/shell-color-scripts/colorscripts | where type == file | get name | where {|x| ($x | path basename) != "pacman-large" and ($x | path basename) != "pacman-large-multiple"} )
            if ($scripts | is-not-empty) {
                let script = ($scripts | shuffle | first 1 | get 0)
                bash $script
            }
        }
    }
}
