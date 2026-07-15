# qol.zsh — Quality of life utilities (parity port of shell/nushell/modules/qol.nu)

timer() {
    local remaining="$1"
    while (( remaining > 0 )); do
        printf "\r⏳ %ds remaining..." "$remaining"
        sleep 1
        (( remaining-- ))
    done
    printf "\r✅ Time's up!              \n"
    command -v osascript &>/dev/null && osascript -e 'display notification "Timer finished!" with title "⏰ Timer"'
}

copy-file-contents() {
    cat "$1" | pbcopy
    echo "📋 Copied contents of $1"
}

copy-path() {
    printf '%s' "$PWD" | pbcopy
    echo "📋 Copied: $PWD"
}

myip() {
    local public local_ip
    public=$(curl -s ifconfig.me)
    local_ip=$(ipconfig getifaddr en0)
    echo "🌐 Public:  $public"
    echo "🏠 Local:   $local_ip"
}

speedtest() {
    curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python3 -
}

isup() {
    local target="$1"
    [[ "$target" != http* ]] && target="https://$target"
    local code
    code=$(curl -s -o /dev/null -w "%{http_code}" "$target")
    if [[ "$code" == 2* || "$code" == 3* ]]; then
        echo "✅ $target is UP ($code)"
    else
        echo "❌ $target is DOWN ($code)"
    fi
}

generate-password() {
    local length="${1:-24}"
    LC_ALL=C tr -dc 'A-Za-z0-9!@#$%^&*()_+' < /dev/urandom | head -c "$length"
    echo
}

generate-uuid() {
    uuidgen | tr '[:upper:]' '[:lower:]'
}

base-64-encode() {
    printf '%s' "$1" | base64
}

base-64-decode() {
    printf '%s' "$1" | base64 -d
}

json-prettier() {
    pbpaste | python3 -m json.tool
}

proj() {
    local name="$1" tmpl="${2:-basic}"
    mkdir "$name" && cd "$name" || return
    case "$tmpl" in
        basic)
            echo "# $name" > README.md
            git init
            ;;
        node)
            npm init -y
            git init
            printf 'node_modules/\n.env\ndist/\n' > .gitignore
            ;;
        python)
            git init
            mkdir src tests
            touch src/__init__.py
            printf 'venv/\n__pycache__/\n*.pyc\n.env\n' > .gitignore
            python3 -m venv venv
            ;;
        *)
            git init
            touch README.md
            ;;
    esac
    echo "📁 Project $name created with $tmpl template"
}

bak() {
    local file="$1"
    local backup="${file}.$(date +%Y%m%d_%H%M%S).bak"
    cp "$file" "$backup"
    echo "💾 Backed up to $backup"
}

note() {
    local action="${1:-show}"
    local notes_file="$HOME/.notes.md"
    case "$action" in
        add)
            shift
            printf '\n- [%s] %s\n' "$(date '+%Y-%m-%d %H:%M')" "$*" >> "$notes_file"
            echo "📝 Note added"
            ;;
        edit)
            nvim "$notes_file"
            ;;
        clear)
            : > "$notes_file"
            echo "🗑️ Notes cleared"
            ;;
        show|*)
            [[ -f "$notes_file" ]] && cat "$notes_file" || echo "📭 No notes yet. Use: note add <text>"
            ;;
    esac
}

sshf() {
    local host
    host=$(grep '^Host ' ~/.ssh/config 2>/dev/null | sed 's/^Host //' | fzf --header 'SSH to:' --height 40% --reverse)
    [[ -n "$host" ]] && ssh "$host"
}

serve() {
    local port="${1:-8080}"
    echo "🌐 Serving $PWD on http://localhost:$port"
    if command -v python3 &>/dev/null; then
        python3 -m http.server "$port"
    elif command -v npx &>/dev/null; then
        npx serve -l "$port"
    else
        echo "❌ Need python3 or npx"
    fi
}

ports() {
    lsof -iTCP -sTCP:LISTEN -n -P
}

extract() {
    local file="$1"
    case "${file:l}" in
        *.zip) unzip "$file" ;;
        *.tar|*.tar.gz|*.tgz|*.tar.xz|*.tar.bz2) tar xf "$file" ;;
        *.7z) 7z x "$file" ;;
        *.rar) unrar x "$file" ;;
        *) echo "Unknown format: $file" ;;
    esac
}

fkill() {
    local pid
    pid=$(ps aux | fzf --header 'Select process to kill' --height 40% | awk '{print $2}')
    [[ -n "$pid" ]] && kill "$pid"
}

cheat() {
    curl -s "cheat.sh/$1"
}
