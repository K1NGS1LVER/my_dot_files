# system.nu — System update, cleanup, sysinfo, fetch, dark mode toggle

def up [] {
    print "🚀 Starting system-wide update..."

    let tools = [
        [name, check, cmds];
        ["🍺 Homebrew",  "brew",  [["brew" "update"] ["brew" "upgrade"] ["brew" "cleanup"]]]
        ["📦 npm",       "npm",   [["npm" "install" "-g" "npm"] ["npm" "update" "-g"]]]
        ["📦 pnpm",      "pnpm",  [["pnpm" "self-update"]]]
        ["🍞 Bun",       "bun",   [["bun" "upgrade"]]]
        ["🦕 Deno",      "deno",  [["deno" "upgrade"]]]
        ["💎 RubyGems",  "gem",   [["gem" "update" "--system"] ["gem" "update"] ["gem" "cleanup"]]]
        ["🧪 Conda",     "conda", [["conda" "update" "-n" "base" "-c" "defaults" "conda" "--yes"]]]
        ["🐍 Pipx",      "pipx",  [["pipx" "upgrade-all"]]]
        ["🍎 App Store", "mas",   [["mas" "upgrade"]]]
        ["💤 Neovim",    "bob",   [["bob" "update" "--all"]]]
        ["📖 tldr",      "tldr",  [["tldr" "--update"]]]
        ["📓 Obsidian",  "python3", [["sh" "-c" "cd ~/notes && python3 ~/dotfiles/scripts/auto_linker.py"]]]
    ]

    for tool in $tools {
        if (which $tool.check | is-not-empty) {
            print $"($tool.name)..."
            for cmd in $tool.cmds {
                let bin = ($cmd | first)
                let cmd_args = ($cmd | skip 1)
                try { ^$bin ...$cmd_args } catch { print $"❌ Failed to run ($bin)" }
            }
        }
    }

    if (which softwareupdate | is-not-empty) {
        print "🖥️ Checking for macOS updates..."
        ^softwareupdate -l
    }

    print "✅ System updated!"
}

def notes-sync [] {
    if ($"($env.HOME)/notes" | path exists) {
        print "📓 Syncing Obsidian notes..."
        ^sh -c "cd ~/notes && python3 ~/dotfiles/scripts/auto_linker.py"
        print "✅ Notes synced!"
    } else {
        print "⚠️  ~/notes not found"
    }
}

def cleanup [] {
    print "🧹 Cleaning Homebrew Cache..."
    if (which brew | is-not-empty) {
        let cache = (^brew --cache)
        try { rm -rf $cache }
    }

    print "🧹 Cleaning Docker (Stopped containers, unused images)..."
    if (which docker | is-not-empty) {
        ^docker system prune -f
    }

    print "🧹 Cleaning User Cache (Logs, Temp files)..."
    try { rm -rf ~/Library/Caches/Homebrew }
    try { rm -rf ~/.npm/_cacache }

    print "✨ Disk space reclaimed!"
}

def sysinfo [] {
    print $"🖥️  OS:      ($nu.os-info.name) ($nu.os-info.arch)"
    print $"🐚 Shell:   Nushell ($nu.current-exe)"
    print $"📁 Home:    ($env.HOME)"
    print $"📂 PWD:     ($env.PWD)"
    print $"🕐 Uptime:  (sys host | get uptime)"
    print $"💾 Memory:  (sys mem | get used) / (sys mem | get total)"
}

def duf [] {
    if (which duf | is-not-empty) {
        ^duf
    } else {
        ^df -h
    }
}

def big-files [count?: int] {
    let n = ($count | default 10)
    ls -la | where type == file | sort-by size -r | first $n | select name size modified
}

def big-directories [count?: int] {
    let n = ($count | default 10)
    ls | where type == dir | each {|d|
        let s = (du $d.name | first | get apparent)
        { name: $d.name, size: $s }
    } | sort-by size -r | first $n
}

def toggle_dark [] {
    ^osascript -e "tell application \"System Events\" to tell appearance preferences to set dark mode to not dark mode"
    print "🔄 Dark mode toggled"
}

def fetch [...args: string] {
    ^fastfetch ...$args
}
