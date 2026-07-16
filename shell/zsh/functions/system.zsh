# system.zsh — System update, cleanup, fetch, dark mode toggle

up() {
    echo "🚀 Starting System-wide Update..."

    # Homebrew runs first, sequentially: node, pnpm, pipx and tldr are all
    # brew-managed on this machine (see Brewfile), so `brew upgrade` can
    # replace their binaries out from under a concurrently-running
    # npm/pnpm/pipx/tldr update.
    if command -v brew &> /dev/null; then
        echo "🍺 Updating Homebrew..."
        brew update && brew upgrade && brew cleanup
    fi

    echo "⏳ Updating remaining tools in parallel..."
    local tmpdir
    tmpdir=$(mktemp -d)

    ( command -v npm  &> /dev/null && npm install -g npm && npm update -g ) &> "$tmpdir/npm.log" &
    ( command -v pnpm &> /dev/null && pnpm self-update ) &> "$tmpdir/pnpm.log" &
    ( command -v pipx &> /dev/null && pipx upgrade-all ) &> "$tmpdir/pipx.log" &
    ( command -v bob  &> /dev/null && bob update --all ) &> "$tmpdir/bob.log" &
    ( command -v tldr &> /dev/null && tldr --update ) &> "$tmpdir/tldr.log" &
    ( [[ -d ~/.local/share/ani-cli ]] && cd ~/.local/share/ani-cli && git pull ) &> "$tmpdir/ani-cli.log" &
    ( [[ -d ~/notes ]] && cd ~/notes && python3 ~/dotfiles/scripts/auto_linker.py ) &> "$tmpdir/obsidian.log" &

    wait

    for logfile in "$tmpdir"/*.log(N); do
        [[ -s "$logfile" ]] || continue
        echo "── ${logfile:t:r} ──"
        cat "$logfile"
    done
    rm -rf "$tmpdir"

    echo "🖥️ Checking for macOS updates..."
    softwareupdate -l

    echo "✅ System Updated!"
}

notes-sync() {
    if [[ -d ~/notes ]]; then
        echo "📓 Syncing Obsidian notes..."
        (cd ~/notes && python3 ~/dotfiles/scripts/auto_linker.py)
        echo "✅ Notes synced!"
    else
        echo "⚠️  ~/notes not found"
    fi
}

cleanup() {
    echo "🧹 Cleaning Homebrew Cache..."
    rm -rf "$(brew --cache)"

    echo "🧹 Cleaning Docker (Stopped containers, unused images)..."
    if command -v docker &> /dev/null; then
        docker system prune -f
    fi

    echo "🧹 Cleaning User Cache (Logs, Temp files)..."
    rm -rf ~/Library/Caches/Homebrew
    rm -rf ~/.npm/_cacache

    echo "✨ Disk space reclaimed!"
}

fetch() {
    case "$1" in
        "go")
            fastfetch --logo ~/.config/fastfetch/logos/go.txt --logo-type file --logo-color-1 blue
            ;;
        "arch")
            fastfetch --logo arch
            ;;
        "random")
            local logos=("arch" "android" "apple" "windows" "linux" "ubuntu" "fedora" "debian")
            local random_index=$(( ($RANDOM % ${#logos[@]}) + 1 ))
            local random_logo=${logos[$random_index]}
            echo "Displaying logo: $random_logo"
            fastfetch --logo "$random_logo"
            ;;
        "")
            fastfetch
            ;;
        *)
            fastfetch --logo "$1"
            ;;
    esac
}

toggle_dark() {
    osascript -e "tell application \"System Events\" to tell appearance preferences to set dark mode to not dark mode"
    if [[ "$(defaults read -g AppleInterfaceStyle 2>/dev/null)" == "Dark" ]]; then
        echo "🌙 Dark Mode enabled"
    else
        echo "☀️ Light Mode enabled"
    fi
}
