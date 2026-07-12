# welcome.zsh — Random startup greeting (color script or cowsay)

welcome-message() {
    local choice=$((RANDOM % 2))
    case $choice in
        0)
            if [[ -d "/opt/shell-color-scripts/colorscripts" ]]; then
                local script
                script=$(find /opt/shell-color-scripts/colorscripts -maxdepth 1 -type f -perm +111 | shuf -n 1)
                [[ -n "$script" ]] && bash "$script"
            fi
            ;;
        1)
            if command -v fortune >/dev/null 2>&1 && command -v cowsay >/dev/null 2>&1; then
                fortune | cowsay -f small
            fi
            ;;
    esac
    return 0
}
