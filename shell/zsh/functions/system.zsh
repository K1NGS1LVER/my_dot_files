# system.zsh — System update, cleanup, fetch, dark mode toggle

up() {
    echo "🚀 Starting System-wide Update..."

    if command -v brew &> /dev/null; then
        echo "🍺 Updating Homebrew..."
        brew update && brew upgrade && brew cleanup
    fi

    if command -v npm &> /dev/null; then
        echo "📦 Updating npm & global packages..."
        npm install -g npm
        npm update -g
    fi

    if command -v pnpm &> /dev/null; then
        echo "📦 Updating pnpm..."
        pnpm self-update
    fi

    if command -v bun &> /dev/null; then
        echo "🍞 Updating Bun..."
        bun upgrade
    fi

    if command -v deno &> /dev/null; then
        echo "🦕 Updating Deno..."
        deno upgrade
    fi

    if command -v pipx &> /dev/null; then
        echo "🐍 Updating Pipx packages..."
        pipx upgrade-all
    fi

    if command -v gem &> /dev/null; then
        echo "💎 Updating System Gems..."
        gem update --system
        gem update
        gem cleanup
    fi

    if command -v bob &> /dev/null; then
        echo "💤 Updating Neovim versions..."
        bob update --all
    fi

    if command -v tldr &> /dev/null; then
        echo "📖 Updating tldr pages..."
        tldr --update
    fi

    if command -v conda &> /dev/null; then
        echo "🧪 Updating Conda..."
        conda update -n base -c defaults conda --yes
    fi

    if [[ -d ~/.local/share/ani-cli ]]; then
        echo "📺 Updating ani-cli..."
        (cd ~/.local/share/ani-cli && git pull && echo "✅ ani-cli updated!")
    fi

    if [[ -d ~/notes ]]; then
        echo "📓 Updating Obsidian MOCs..."
        (cd ~/notes && python3 ~/dotfiles/scripts/auto_linker.py)
    fi

    if command -v mas &> /dev/null; then
        echo "🍎 Updating Mac App Store apps..."
        mas upgrade
    fi

    echo "🖥️ Checking for macOS updates..."
    softwareupdate -l

    echo "✅ System Updated!"
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
