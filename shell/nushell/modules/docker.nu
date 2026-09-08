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
