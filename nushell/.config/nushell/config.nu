# config.nu — Nushell Configuration (0.110.0)
# Optimized for M2 MacBook Air · Portable by design

# ─────────────────────────────────────────────
# PLATFORM DETECTION
# ─────────────────────────────────────────────

const IS_MACOS = ($nu.os-info.name == "macos")

# ─────────────────────────────────────────────
# PROMPT (suppressed — Starship handles it)
# ─────────────────────────────────────────────

$env.PROMPT_INDICATOR = ""
$env.PROMPT_INDICATOR_VI_INSERT = ""
$env.PROMPT_INDICATOR_VI_NORMAL = ""
$env.PROMPT_MULTILINE_INDICATOR = ""

# ─────────────────────────────────────────────
# ALIASES — Navigation
# ─────────────────────────────────────────────

alias home = cd ~
alias .. = cd ..
alias ... = cd ../..
alias .... = cd ../../..
alias ..... = cd ../../../../..

# ─────────────────────────────────────────────
# ALIASES — Core Replacements
# ─────────────────────────────────────────────

alias c = clear
alias reload = exec nu
alias ll = ls -l
alias la = ls -a
alias lla = ls -la
alias cat = ^bat
alias help = ^tldr
alias sed = ^sd
alias fetch = ^fastfetch
alias lg = ^lazygit
alias src = view-source
alias g = git
alias gs = ^git status


# ─────────────────────────────────────────────
# ALIASES — Editor
# ─────────────────────────────────────────────

alias vim = ^nvim
alias vi = ^nvim
alias v = ^nvim
alias nv = ^nvim
alias og = ^/usr/bin/vim
alias nvconfig = ^nvim ~/.config/nvim/
alias nvguide = ^nvim ~/.config/nvim/SETUP_GUIDE.md
alias nvcheat = ^nvim ~/.config/nvim/CHEATSHEET.md

$env.config.buffer_editor = "nvim"

# ─────────────────────────────────────────────
# ALIASES — Neovim Profiles
# ─────────────────────────────────────────────

def nvim-kick [] {
    $env.NVIM_APPNAME = "nvim-kickstart"
    ^nvim
}

def nvim-play [] {
    $env.NVIM_APPNAME = "nvim-playground"
    let bob_bin = ([$env.HOME ".local" "share" "bob" "nightly" "bin" "nvim"] | path join)
    ^$bob_bin
}

def nvim-mini [] {
    $env.NVIM_APPNAME = "mini"
    ^nvim
}

# ─────────────────────────────────────────────
# ALIASES — Kotlin
# ─────────────────────────────────────────────

alias k = ^kotlin
alias kc = ^kotlinc

# ─────────────────────────────────────────────
# ALIASES — Media & Apps
# ─────────────────────────────────────────────

alias play = ^mpv
alias meow = echo
alias bark = ls
alias watch = ^open -a IINA
alias book = ^open -a Books

# ─────────────────────────────────────────────
# ALIASES — Anime
# ─────────────────────────────────────────────

alias anim = ^ani-cli
alias anim-c = ^ani-cli -c
alias anim-res = ^ani-cli -q 1080
alias anim-dl = ^ani-cli -d

# ─────────────────────────────────────────────
# ALIASES — AI / Misc
# ─────────────────────────────────────────────

alias ai = ^ollama run qwen2.5-coder:7b
alias dark = toggle_dark
alias C = pbcopy
alias packettracer = ^open "/Applications/Cisco Packet Tracer 9.0.0/Cisco Packet Tracer 9.0.app"
alias goodnight = ^sh ~/scripts/goodnight.sh
alias gray = ^shortcuts run "Toggle Grayscale"
alias sepia = ^shortcuts run "Sepia Mode"

# ─────────────────────────────────────────────
# CUSTOM FUNCTIONS
# ─────────────────────────────────────────────

# ─────────────────────────────────────────────
# QOL — Stopwatch & Timer
# ─────────────────────────────────────────────


# Countdown timer
def timer [seconds: int] {
    mut remaining = $seconds
    while $remaining > 0 {
        print -n $"\r⏳ ($remaining)s remaining..."
        sleep 1sec
        $remaining = $remaining - 1
    }
    print "\r✅ Time's up!              "
    if ($nu.os-info.name == "macos") {
        ^osascript -e 'display notification "Timer finished!" with title "⏰ Timer"'
    }
}

# ─────────────────────────────────────────────
# QOL — Clipboard Helpers
# ─────────────────────────────────────────────

# Copy file contents to clipboard
def copy-file-contents [file: string] {
    if ($nu.os-info.name == "macos") {
        open --raw $file | ^pbcopy
        print $"📋 Copied contents of ($file)"
    } else {
        open --raw $file | ^xclip -selection clipboard
        print $"📋 Copied contents of ($file)"
    }
}

# Copy current path to clipboard
def copy-path [] {
    if ($nu.os-info.name == "macos") {
        $env.PWD | ^pbcopy
    } else {
        $env.PWD | ^xclip -selection clipboard
    }
    print $"📋 Copied: ($env.PWD)"
}

# ─────────────────────────────────────────────
# QOL — Network
# ─────────────────────────────────────────────

# Quick IP info
def myip [] {
    let public = (^curl -s ifconfig.me | str trim)
    let local = if ($nu.os-info.name == "macos") {
        ^ipconfig getifaddr en0 | str trim
    } else {
        ^hostname -I | split row " " | first | str trim
    }
    print $"🌐 Public:  ($public)"
    print $"🏠 Local:   ($local)"
}

# Speed test (requires curl)
def speedtest [] {
    ^curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | ^python3 -
}

# Check if a site is up
def isup [url: string] {
    let target = if ($url | str starts-with "http") { $url } else { $"https://($url)" }
    let code = (^curl -s -o /dev/null -w "%{http_code}" $target | str trim)
    if ($code | str starts-with "2") or ($code | str starts-with "3") {
        print $"✅ ($target) is UP \(($code)\)"
    } else {
        print $"❌ ($target) is DOWN \(($code)\)"
    }
}

# ─────────────────────────────────────────────
# QOL — Disk & System Info
# ─────────────────────────────────────────────

# Disk usage summary
def duf [] {
    if (which duf | is-not-empty) {
        ^duf
    } else {
        ^df -h
    }
}

# Top N largest files in current directory
def big-files [count?: int] {
    let n = ($count | default 10)
    ls -la | where type == file | sort-by size -r | first $n | select name size modified
}

# Top N largest directories
def big-directories [count?: int] {
    let n = ($count | default 10)
    ls | where type == dir | each {|d|
        let s = (du $d.name | first | get apparent)
        { name: $d.name, size: $s }
    } | sort-by size -r | first $n
}

# System info summary
def sysinfo [] {
    print $"🖥️  OS:      ($nu.os-info.name) ($nu.os-info.arch)"
    print $"🐚 Shell:   Nushell ($nu.current-exe)"
    print $"📁 Home:    ($env.HOME)"
    print $"📂 PWD:     ($env.PWD)"
    print $"🕐 Uptime:  (sys host | get uptime)"
    print $"💾 Memory:  (sys mem | get used) / (sys mem | get total)"
}

# ─────────────────────────────────────────────
# QOL — String & Data Helpers
# ─────────────────────────────────────────────

# Generate a random password
def generate-password [length?: int] {
    let len = ($length | default 24)
    random chars -l $len
}

# UUID generator
def generate-uuid [] {
    if ($nu.os-info.name == "macos") {
        ^uuidgen | str downcase | str trim
    } else {
        open /proc/sys/kernel/random/uuid | str trim
    }
}

# Base64 encode/decode
def base-64-encode [input: string] { $input | encode base64 }
def base-64-decode [input: string] { $input | decode base64 | decode utf-8 }

# JSON pretty print from clipboard
def json-prettier [] {
    if ($nu.os-info.name == "macos") {
        ^pbpaste | from json | to json -i 2
    } else {
        ^xclip -selection clipboard -o | from json | to json -i 2
    }
}

# ─────────────────────────────────────────────
# QOL — Project Scaffolding
# ─────────────────────────────────────────────

# Quick project init
def --env proj [name: string, template?: string] {
    let tmpl = ($template | default "basic")
    mkdir $name
    cd $name

    match $tmpl {
        "basic" => {
            touch README.md
            "# " + $name | save README.md
            ^git init
        }
        "node" => {
            ^npm init -y
            ^git init
            ".node_modules/\n.env\ndist/" | save .gitignore
        }
        "python" => {
            ^git init
            mkdir src tests
            touch src/__init__.py
            "venv/\n__pycache__/\n*.pyc\n.env" | save .gitignore
            ^python3 -m venv venv
        }
        _ => {
            ^git init
            touch README.md
        }
    }
    print $"📁 Project ($name) created with ($tmpl) template"
}

# ─────────────────────────────────────────────
# QOL — Backup Helper
# ─────────────────────────────────────────────

# Quick backup of a file
def bak [file: string] {
    let timestamp = (date now | format date "%Y%m%d_%H%M%S")
    let backup = $"($file).($timestamp).bak"
    cp $file $backup
    print $"💾 Backed up to ($backup)"
}

# ─────────────────────────────────────────────
# QOL — Notes (quick scratch pad)
# ─────────────────────────────────────────────

def note [action?: string, ...content: string] {
    let notes_file = ([$env.HOME ".notes.md"] | path join)

    match ($action | default "show") {
        "add" => {
            let text = ($content | str join " ")
            let timestamp = (date now | format date "%Y-%m-%d %H:%M")
            $"\n- [($timestamp)] ($text)" | save --append $notes_file
            print $"📝 Note added"
        }
        "edit" => {
            ^nvim $notes_file
        }
        "clear" => {
            "" | save --force $notes_file
            print "🗑️ Notes cleared"
        }
        "show" | _ => {
            if ($notes_file | path exists) {
                open --raw $notes_file
            } else {
                print "📭 No notes yet. Use: note add <text>"
            }
        }
    }
}

# ─────────────────────────────────────────────
# QOL — Docker Shortcuts
# ─────────────────────────────────────────────

def dps [] { ^docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}" }
def dimg [] { ^docker images --format "table {{.Repository}}\t{{.Tag}}\t{{.Size}}" }
def dstop [] { ^docker stop (^docker ps -q | lines) }
def dclean [] { ^docker system prune -af }

# Interactive container selector
def dsh [] {
    let container = (^docker ps --format "{{.Names}}" | ^fzf --header 'Select container' --height 40% --reverse | str trim)
    if ($container | is-not-empty) {
        ^docker exec -it $container /bin/sh
    }
}

# ─────────────────────────────────────────────
# QOL — SSH Helpers
# ─────────────────────────────────────────────

# Fuzzy SSH from ~/.ssh/config
def sshf [] {
    let host = (open ~/.ssh/config | lines | where {|l| $l =~ "^Host " } | each {|l| $l | str replace "Host " "" | str trim } | str join "\n" | ^fzf --header 'SSH to:' --height 40% --reverse | str trim)
    if ($host | is-not-empty) {
        ^ssh $host
    }
}

# ─────────────────────────────────────────────
# QOL — Serve current directory
# ─────────────────────────────────────────────

def serve [port?: int] {
    let p = ($port | default 8080)
    print $"🌐 Serving ($env.PWD) on http://localhost:($p)"
    if (which python3 | is-not-empty) {
        ^python3 -m http.server $p
    } else if (which npx | is-not-empty) {
        ^npx serve -l $p
    } else {
        print "❌ Need python3 or npx"
    }
}

# list listening TCP ports (requires lsof)
def ports [] { ^lsof -iTCP -sTCP:LISTEN -n -P | lines | skip 1 | parse "{cmd} {pid} {user} {rest}" }

# extract various archive formats based on file extension
def extract [file: string] {
    match ($file | path parse | get extension | str downcase) {
        "zip" => { ^unzip $file }
        "tar" | "gz" | "tgz" | "xz" | "bz2" => { ^tar xf $file }
        "7z" => { ^7z x $file }
        "rar" => { ^unrar x $file }
        _ => { print $"Unknown format: ($file)" }
    }
}


# kill process by fuzzy name (requires fzf) 
def fkill [] {
    let pid = (^ps aux | ^fzf --header 'Select process to kill' --height 40% | awk '{print $2}' | str trim)
    if ($pid | is-not-empty) { kill ($pid | into int) }
}

# fetch cheat sheet from cheat.sh 
def cheat [query: string] { ^curl -s $"cheat.sh/($query)" }

# ─────────────────────────────────────────────
# TERMINAL MULTIPLEXER
# ─────────────────────────────────────────────

alias ks = kitty --session ~/.config/kitty/session.conf
alias t = ttmux
alias tk = tkill

# ttmux: abduco wrapper that defaults to a "main" session but allows pass-through
def --wrapped ttmux [...args: string] {
    let shell = "nu"
    let default_key = "^a"

    if ($args | is-empty) {
        # Default: attach/create "main" with Ctrl-a and nu shell
        ^abduco -e $default_key -A main $shell
    } else if ($args | length) == 1 {
        # If single arg, treat as session name (e.g., ttmux pp)
        let name = ($args | first)
        if ($name | str starts-with "-") {
            # If it's a flag (like -l), pass it through directly
            ^abduco ...$args
        } else {
            # Otherwise, attach/create a session with that name
            ^abduco -e $default_key -A $name $shell
        }
    } else {
        # Pass-through all other complex arguments to abduco
        ^abduco ...$args
    }
}

def ntmux [...args: string] {
    if ($args | is-empty) {
        ^zellij attach -c "dan"
    } else {
        ^zellij ...$args
    }
}

# Kills an abduco session by name
def tkill [name: string] {
    # Find abduco processes where the command line contains the session name
    let sessions = (ps -l | where command =~ "abduco" | where command =~ $name)
    
    if ($sessions | is-empty) {
        print $"No abduco session found matching: ($name)"
    } else {
        $sessions | each { |it| 
            kill $it.pid
            print $"Terminated abduco session: ($name) \(PID: ($it.pid)\)"
        }
    }
}

# ─────────────────────────────────────────────
# FUZZY FILE OPENER
# ─────────────────────────────────────────────

def vf [] {
    let file = (^fzf --preview 'bat --style=numbers --color=always --line-range :500 {}' | str trim)
    if ($file | is-not-empty) {
        ^nvim $file
    }
}

# ─────────────────────────────────────────────
# CAPTURE OUTPUT
# ─────────────────────────────────────────────

def cap [cmd: string, ...args: string] {
    let timestamp = (date now | format date "%Y%m%d_%H%M%S")
    let logfile = $"capture_($timestamp).txt"
    print $"Saving output to ($logfile)..."
    ^$cmd ...$args | tee { save --force $logfile }
}

# ─────────────────────────────────────────────
# UPSCALE (Real-ESRGAN)
# ─────────────────────────────────────────────

def upscale [...args: string] {
    let upscale_dir = ([$env.HOME "projects" "pythonVishal" "Real-ESRGAN-0.3.0"] | path join)
    let bin = ([$upscale_dir "realesrgan-ncnn-vulkan"] | path join)
    let models = ([$upscale_dir "models"] | path join)
    ^$bin -m $models -n realesrgan-x4plus ...$args
}

def upscale-anime [...args: string] {
    let upscale_dir = ([$env.HOME "projects" "pythonVishal" "Real-ESRGAN-0.3.0"] | path join)
    let bin = ([$upscale_dir "realesrgan-ncnn-vulkan"] | path join)
    let models = ([$upscale_dir "models"] | path join)
    ^$bin -m $models -n realesrgan-x4plus-anime ...$args
}

# ─────────────────────────────────────────────
# TODOIST
# ─────────────────────────────────────────────

def todo [] {
    let selection = (
        ^todo-go list '(today | overdue | #Inbox | recurring)'
        | ^fzf --delimiter='\t' --with-nth=2 --header 'Inbox, Today & Recurring: Select to complete (ESC cancel)' --height 40% --reverse
        | str trim
    )
    if ($selection | is-not-empty) {
        let id = ($selection | split words | first)
        ^todo-go close $id
    }
}

# ─────────────────────────────────────────────
# BROWSER — Unified URL Handler
# ─────────────────────────────────────────────

def browse [browser: string, keyword?: string, ...query: string] {
    let is_mac = ($nu.os-info.name == "macos")
    let opener = if $is_mac { "open" } else { "xdg-open" }

    let sites = [
        [aliases, base, search];
        ["youtube|yt",       "https://www.youtube.com",              "/results?search_query="]
        ["github|gh",        "https://github.com",                   "/search?q="]
        ["linkedin|li",      "https://www.linkedin.com",             "/search/results/all/?keywords="]
        ["christ|cu",        "https://christuniversity.in",          ""]
        ["hianime|hi",       "https://hianimez.is/home",             "https://hianimez.is/search?keyword="]
        ["monkeytype|mt",    "https://monkeytype.com",               ""]
        ["keybr|kb",         "https://www.keybr.com",                ""]
        ["greasyfork|gf",    "https://greasyfork.org",               "/scripts/search?q="]
        ["openjs",           "https://openuserjs.org",               "/?q="]
        ["classroom|cl",     "https://classroom.google.com",         ""]
        ["reddit|rd",        "https://www.reddit.com",               "/search/?q="]
        ["x|twitter",        "https://x.com",                        "/search?q="]
        ["google|g",         "https://www.google.com",               "/search?q="]
        ["net",              "http://192.168.100.100:8090/",         ""]
    ]

    if ($keyword == null or ($keyword | is-empty)) {
        if $is_mac { ^open -a $browser } else { ^$opener "" }
        return
    }

    let matched = ($sites | where {|s|
        ($s.aliases | split row "|") | any {|a| $a == $keyword }
    })

    if ($matched | is-not-empty) {
        let site = ($matched | first)
        let open_args = if $is_mac { ["-a" $browser] } else { [] }
        if ($query | is-empty) {
            ^$opener ...$open_args $site.base
        } else {
            let q = ($query | str join "+")
            let url = if ($site.search | is-empty) {
                $site.base
            } else if ($site.search | str starts-with "/") {
                let clean_base = ($site.base | str replace -r '/$' '')
                $"($clean_base)($site.search)($q)"
            } else {
                $"($site.search)($q)"
            }
            ^$opener ...$open_args $url
        }
    } else {
        let url = if ($keyword | str starts-with "http") { $keyword } else { $"https://($keyword)" }
        let open_args = if $is_mac { ["-a" $browser] } else { [] }
        ^$opener ...$open_args $url
    }
}

def brave [keyword?: string, ...query: string] {
    let browser = if ($nu.os-info.name == "macos") { "Brave Browser" } else { "brave-browser" }
    browse $browser $keyword ...$query
}

def fox [keyword?: string, ...query: string] {
    let browser = if ($nu.os-info.name == "macos") { "Firefox" } else { "firefox" }
    browse $browser $keyword ...$query
}

def wolf [keyword?: string, ...query: string] {
    let browser = if ($nu.os-info.name == "macos") { "LibreWolf" } else { "librewolf" }
    browse $browser $keyword ...$query
}
# ─────────────────────────────────────────────
# YAZI — File Manager with CWD sync
# ─────────────────────────────────────────────

def --env --wrapped y [...args] {
    let tmp = ([$env.HOME ".yazi_cwd"] | path join)

    if ("ZELLIJ" in $env) {
        let zellij_conf = ([$env.HOME ".config" "yazi" "zellij"] | path join)
        $env.YAZI_CONFIG_HOME = $zellij_conf
        ^yazi ...$args --cwd-file $tmp
    } else {
        ^yazi ...$args --cwd-file $tmp
    }

    if ($tmp | path exists) {
        let cwd = (open --raw $tmp | str trim)
        if ($cwd | is-not-empty) and ($cwd != $env.PWD) {
            cd $cwd
        }
        rm -f $tmp
    }
}

# ─────────────────────────────────────────────
# KOTLIN — Compile & Run
# ─────────────────────────────────────────────

def krun [file: string] {
    let stem = ($file | path parse | get stem)
    let jar = $"($stem).temp.jar"
    ^kotlinc $file -include-runtime -d $jar
    if ($jar | path exists) {
        ^java -jar $jar
        rm -f $jar
    } else {
        print "❌ Compilation failed."
    }
}

# ─────────────────────────────────────────────
# SYSTEM UPDATE — Multi-tool
# ─────────────────────────────────────────────

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

# ─────────────────────────────────────────────
# DISK CLEANUP
# ─────────────────────────────────────────────

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


def pdf [...args: string] {
    if ($nu.os-info.name == "macos") {
        ^open -a sioyek --new-window ...$args
    } else {
        ^sioyek --new-window ...$args
    }
}

# ─────────────────────────────────────────────
# CATPPUCCIN MACCHIATO — Color Palette
# ─────────────────────────────────────────────

let catppuccin = {
    rosewater: "#f4dbd6"
    flamingo:  "#f0c1ce"
    pink:      "#f5bde6"
    mauve:     "#c6a0f6"
    red:       "#ed8796"
    maroon:    "#ee99a0"
    peach:     "#f5a97f"
    yellow:    "#eed49f"
    green:     "#a6da95"
    teal:      "#8bd5ca"
    sky:       "#91d7e3"
    sapphire:  "#7dc4e4"
    blue:      "#8aadf4"
    lavender:  "#b7bdf8"
    text:      "#cad3f5"
    subtext1:  "#b8c0e0"
    subtext0:  "#a5adcb"
    overlay2:  "#939ab7"
    overlay1:  "#8087a2"
    overlay0:  "#6e738d"
    surface2:  "#5b6078"
    surface1:  "#494d64"
    surface0:  "#363a4f"
    base:      "#24273a"
    mantle:    "#1e2030"
    crust:     "#181926"
}

# ─────────────────────────────────────────────
# CONFIGURATION
# ─────────────────────────────────────────────

$env.config = {
    show_banner: false
    edit_mode: vi
    highlight_resolved_externals: true

    ls: {
        use_ls_colors: true
        clickable_links: true
    }

    rm: {
        always_trash: true
    }

    table: {
        mode: rounded # basic, compact, compact_double, light, thin, with_love, rounded, reinforced, heavy, none, other
        index_mode: always # "always" show indexes, "never" show indexes, "auto" = show indexes when a table has "index" column
        show_empty: true # show 'empty list' and 'empty record' placeholders for command output
        padding: { left: 1, right: 1 } # a left right padding of each column in a table
        trim: {
            methodology: wrapping # wrapping or truncating
            wrapping_try_keep_words: true # A strategy used by the 'wrapping' methodology
            truncating_suffix: "..." # A suffix used by the 'truncating' methodology
        }
        header_on_separator: false # show header text on separator/border line
        # abbreviated_row_count: 10 # limit data rows from top and bottom after reaching a set point
    }

    error_style: "fancy" # "fancy" or "plain" for screen reader-friendly error messages

    color_config: {
        separator:                  $catppuccin.overlay0
        leading_trailing_space_bg:  { attr: n }
        header:                     { fg: $catppuccin.blue attr: b }
        empty:                      $catppuccin.blue
        bool:                       $catppuccin.peach
        int:                        $catppuccin.peach
        filesize:                   $catppuccin.sapphire
        duration:                   $catppuccin.subtext1
        date:                       $catppuccin.teal
        range:                      $catppuccin.peach
        float:                      $catppuccin.peach
        string:                     $catppuccin.green
        nothing:                    $catppuccin.peach
        binary:                     $catppuccin.peach
        cell-path:                  $catppuccin.text
        row_index:                  { fg: $catppuccin.mauve attr: b }
        record:                     $catppuccin.text
        list:                       $catppuccin.text
        block:                      $catppuccin.text
        hints:                      $catppuccin.overlay1
        search_results:             { fg: $catppuccin.base bg: $catppuccin.yellow }

        shape_and:                  $catppuccin.mauve
        shape_binary:               $catppuccin.mauve
        shape_block:                $catppuccin.blue
        shape_bool:                 $catppuccin.teal
        shape_custom:               $catppuccin.green
        shape_datetime:             $catppuccin.teal
        shape_directory:            $catppuccin.blue
        shape_external:             $catppuccin.red
        shape_external_resolved:    $catppuccin.green
        shape_externalarg:          $catppuccin.green
        shape_filepath:             $catppuccin.teal
        shape_flag:                 $catppuccin.sky
        shape_float:                $catppuccin.mauve
        shape_garbage:              { fg: $catppuccin.red attr: b }
        shape_globpattern:          $catppuccin.teal
        shape_int:                  $catppuccin.mauve
        shape_internalcall:         $catppuccin.green
        shape_keyword:              $catppuccin.mauve
        shape_list:                 $catppuccin.sky
        shape_literal:              $catppuccin.blue
        shape_match_pattern:        $catppuccin.green
        shape_matching_brackets:    { attr: u }
        shape_nothing:              $catppuccin.teal
        shape_operator:             $catppuccin.yellow
        shape_or:                   $catppuccin.mauve
        shape_pipe:                 $catppuccin.mauve
        shape_range:                $catppuccin.yellow
        shape_record:               $catppuccin.sky
        shape_redirection:          $catppuccin.mauve
        shape_signature:            $catppuccin.green
        shape_string:               $catppuccin.green
        shape_string_interpolation: $catppuccin.teal
        shape_table:                $catppuccin.blue
        shape_variable:             $catppuccin.flamingo
        shape_vardecl:              $catppuccin.flamingo
    }

    hooks: {
        pre_execution: [
            {||
                if ("ZELLIJ" in $env) {
                    let cmd = (commandline | default "" | str trim | str substring 0..15)
                    if ($cmd | is-not-empty) {
                        ^zellij action rename-tab $cmd out+err> /dev/null
                    }
                }
            }
        ]
        pre_prompt: [
            {||
                if ("ZELLIJ" in $env) {
                    let tab_name = ($env.PWD | path basename)
                    ^zellij action rename-tab $tab_name out+err> /dev/null
                }
            }
        ]
    }
  completions: {
    case_sensitive: false # set to true to enable case-sensitive completions
    quick: true          # set to false to prevent auto-selecting completions
    partial: true        # set to false to prevent partial filling of the matching completion
    algorithm: "prefix"    # prefix or fuzzy
    external: {
        enable: true       # set to false to disable external completions
        max_results: 100   # maximum number of results to return from external completers
    }
    use_ls_colors : true   # whether to use ls colors in file completions
  }
  buffer_editor: "nvim"
  cursor_shape: {
    vi_insert: line
    vi_normal: block
    emacs: line
  }
  history: {
    file_format: "sqlite"  # "sqlite" or "plain"
    max_size: 100_000      # maximum number of history entries to keep
    sync_on_enter: true    # whether to sync history to disk after each command
    isolation: false       # whether to isolate history between different shell instances
  }
}

# ─────────────────────────────────────────────
# FILE ASSOCIATIONS — smart-open (Explicit open command)
# ─────────────────────────────────────────────

def smart-open [cmd_name: string] {
    let filepath = ($cmd_name | path expand)
    if not ($filepath | path exists) { 
        print $"(ansi red)Error: File not found: ($cmd_name)(ansi reset)"
        return 
    }

    let parsed = ($filepath | path parse)
    let ext = ($parsed.extension | str downcase)

    let editor_exts = ["py" "js" "ts" "java" "cpp" "c" "go" "rs" "css" "sh" "nu" "toml" "yaml" "yml" "json" "md" "lua" "rb" "zig" "swift" "kt"]
    let media_exts  = ["mp4" "mov" "avi" "mkv" "mp3" "wav" "ogg" "flac" "webm" "m4a"]
    let image_exts  = ["png" "jpg" "jpeg" "gif" "webp" "bmp" "tiff" "svg"]
    let doc_exts    = ["docx" "doc" "xlsx" "xls" "pptx" "ppt" "csv" "rtf"]

    let is_mac = ($nu.os-info.name == "macos")

    if ($ext in $editor_exts) {
        ^nvim $filepath
    } else if ($ext == "pdf") {
        # Force PDFs to open in Sioyek
        if $is_mac { ^open -a sioyek $filepath } else { ^sioyek $filepath }
    } else if ($ext == "epub") {
        if $is_mac { ^open -a Books $filepath } else { ^xdg-open $filepath }
    } else if ($ext == "html" or $ext == "htm") {
        if $is_mac { ^open $filepath } else { ^xdg-open $filepath }
    } else if ($ext in $media_exts) {
        if $is_mac { ^open -a IINA $filepath } else { ^xdg-open $filepath }
    } else if ($ext in $image_exts or $ext in $doc_exts) {
        if $is_mac { ^open $filepath } else { ^xdg-open $filepath }
    } else {
        if $is_mac { ^open $filepath } else { ^xdg-open $filepath }
    }
}

alias open = smart-open

# ─────────────────────────────────────────────
# PLUGINS & EXTERNAL SOURCES
# ─────────────────────────────────────────────

# Carapace completions
$env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense'
let cache_root = ([$env.HOME ".cache"] | path join)
let carapace_cache = ($cache_root | path join "carapace")
let carapace_init = ($carapace_cache | path join "init.nu")
mkdir $carapace_cache
if not ($carapace_init | path exists) {
    ^carapace _carapace nushell | save --force $carapace_init
}
source ~/.cache/carapace/init.nu

# Atuin (shared history)
let atuin_cache = ($cache_root | path join "atuin")
let atuin_init = ($atuin_cache | path join "init.nu")
mkdir $atuin_cache
if not ($atuin_init | path exists) {
    ^atuin init nu | save --force $atuin_init
}
source ~/.cache/atuin/init.nu

# Starship (prompt)
let starship_cache = ($cache_root | path join "starship")
let starship_init = ($starship_cache | path join "init.nu")
mkdir $starship_cache
if not ($starship_init | path exists) {
    ^starship init nu | save --force $starship_init
}
source ~/.cache/starship/init.nu

# Zoxide
source ./zoxide.nu
# ─────────────────────────────────────────────
# WELCOME MESSAGE
# ─────────────────────────────────────────────

def --env welcome-message [] {
    let choice = (random int 0..2)
    if $choice == 0 {
        if (which pokemon-colorscripts | is-not-empty) {
            ^pokemon-colorscripts -r
        }
    } else if $choice == 1 {
        let scripts_dir = "/opt/shell-color-scripts/colorscripts"
        if ($scripts_dir | path exists) {
            let scripts = (ls $scripts_dir | get name)
            if ($scripts | is-not-empty) {
                let script = ($scripts | shuffle | first 1 | get 0)
                bash $script
            }
        }
    } else {
        if (which fortune | is-not-empty) and (which cowsay | is-not-empty) {
            ^fortune | ^cowsay -f small
        }
    }
}

 welcome-message

