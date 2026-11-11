# docker.nu — Docker shortcuts

def dps [] { ^docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}" }
def dimg [] { ^docker images --format "table {{.Repository}}\t{{.Tag}}\t{{.Size}}" }
def dstop [] {
    let ids = (^docker ps -q | lines)
    if ($ids | is-not-empty) {
        ^docker stop ...$ids
    } else {
        "No running containers to stop."
    }
}
def dclean [] { ^docker system prune -af }

# Interactive container selector
def dsh [] {
    let container = (^docker ps --format "{{.Names}}" | ^fzf --header 'Select container' --height 40% --reverse | str trim)
    if ($container | is-not-empty) {
        ^docker exec -it $container /bin/sh
    }
}

# Light low-memory Docker VM (colima). Replace mem-arg to raise, e.g. `dkup 4`
def dkup [mem: int = 2] { ^colima start --cpu 2 --memory $mem --disk 15 }

# Free all VM memory when done working
def dkdown [] { ^colima stop }

def kcreate [] { ^kind create cluster --config ~/.config/kind/config.yaml }

def kdelete [] { ^kind delete cluster }
