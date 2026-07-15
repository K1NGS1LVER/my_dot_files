# docker.zsh — Docker shortcuts (parity port of shell/nushell/modules/docker.nu)

dps() {
    docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
}

dimg() {
    docker images --format "table {{.Repository}}\t{{.Tag}}\t{{.Size}}"
}

dstop() {
    docker stop $(docker ps -q)
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
