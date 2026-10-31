# welcome.zsh — Random startup greeting (pokemon colorscript, shell color script, or cowsay)

welcome-message() {
    local choice=$((RANDOM % 3))
    case $choice in
        0)
            if command -v pokemon-colorscripts >/dev/null 2>&1; then
                pokemon-colorscripts -r
            elif [[ -d "/opt/shell-color-scripts/colorscripts" ]]; then
                local script
                script=$(find /opt/shell-color-scripts/colorscripts -maxdepth 1 -type f -perm +111 \( -name 'pacman-large' -o -name 'pacman-large-multiple' \) -prune -o -print | shuf -n 1)
                [[ -n "$script" && -x "$script" ]] && bash "$script"
            elif command -v fortune >/dev/null 2>&1 && command -v cowsay >/dev/null 2>&1; then
                fortune | cowsay -f small
            fi
            ;;
        1)
            if [[ -d "/opt/shell-color-scripts/colorscripts" ]]; then
                local script
                script=$(find /opt/shell-color-scripts/colorscripts -maxdepth 1 -type f -perm +111 \( -name 'pacman-large' -o -name 'pacman-large-multiple' \) -prune -o -print | shuf -n 1)
                [[ -n "$script" && -x "$script" ]] && bash "$script"
            elif command -v pokemon-colorscripts >/dev/null 2>&1; then
                pokemon-colorscripts -r
            elif command -v fortune >/dev/null 2>&1 && command -v cowsay >/dev/null 2>&1; then
                fortune | cowsay -f small
            fi
            ;;
        2)
            if command -v fortune >/dev/null 2>&1 && command -v cowsay >/dev/null 2>&1; then
                fortune | cowsay -f small
            elif command -v pokemon-colorscripts >/dev/null 2>&1; then
                pokemon-colorscripts -r
            elif [[ -d "/opt/shell-color-scripts/colorscripts" ]]; then
                local script
                script=$(find /opt/shell-color-scripts/colorscripts -maxdepth 1 -type f -perm +111 \( -name 'pacman-large' -o -name 'pacman-large-multiple' \) -prune -o -print | shuf -n 1)
                [[ -n "$script" && -x "$script" ]] && bash "$script"
            fi
            ;;
    esac
    return 0
}
