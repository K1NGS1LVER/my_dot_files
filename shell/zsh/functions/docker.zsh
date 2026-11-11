# docker.zsh — Docker shortcuts (parity port of shell/nushell/modules/docker.nu)

dps() {
    docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
}

dimg() {
    docker images --format "table {{.Repository}}\t{{.Tag}}\t{{.Size}}"
}

dstop() {
    local ids
    ids=$(docker ps -q)
    if [[ -n "$ids" ]]; then
        docker stop $ids
    else
        echo "No running containers to stop."
    fi
}

dclean() {
    docker system prune -af
}

# Interactive container selector
dsh() {
    local container
    container=$(docker ps --format "{{.Names}}" | fzf --header 'Select container' --height 40% --reverse)
    [[ -n "$container" ]] && docker exec -it "$container" /bin/sh
}

# Light low-memory Docker VM (colima). Replace mem-arg to raise, e.g. `dkup 4`
dkup() {
    colima start --cpu 2 --memory "${1:-2}" --disk 15
}

# Free all VM memory when done working
dkdown() {
    colima stop
}

kcreate() {
    kind create cluster --config ~/.config/kind/config.yaml
}

kdelete() {
    kind delete cluster
}
