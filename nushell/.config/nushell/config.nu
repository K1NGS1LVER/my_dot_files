# config.nu - Nushell Configuration (0.110.0)

# zoxide for yazi
source ./zoxide.nu

# --- ALIASES ---
alias k = ^kotlin
alias kc = ^kotlinc
alias og = ^/usr/bin/vim
alias vim = ^nvim
alias vi = ^nvim
alias v = ^nvim
alias lg = ^lazygit
alias nv = ^nvim
alias nvconfig = ^nvim ~/.config/nvim/
alias nvguide = ^nvim ~/.config/nvim/SETUP_GUIDE.md
alias nvcheat = ^nvim ~/.config/nvim/CHEATSHEET.md
alias home = cd ~
alias c = clear
alias reload = exec nu
alias .. = cd ..
alias ... = cd ../..
alias .... = cd ../../..
alias ..... = cd ../../../../..
alias ll = ls -l
alias la = ls -a
alias lla = ls -la
alias meow = echo
alias bark = ls
alias cat = ^bat

# Hide default Nushell prompt indicators to let Starship handle the UI
$env.PROMPT_INDICATOR = ""
$env.PROMPT_INDICATOR_VI_INSERT = ""
$env.PROMPT_INDICATOR_VI_NORMAL = ""
$env.PROMPT_MULTILINE_INDICATOR = ""
alias help = ^tldr
alias sed = ^sd
alias play = ^mpv
alias watch = ^open -a IINA
alias book = ^open -a Books
alias ai = ^ollama run qwen2.5-coder:7b
alias nv-play = ^NVIM_APPNAME=nvim-playground $env.HOME/.local/share/bob/nightly/bin/nvim
alias nv-kick = ^NVIM_APPNAME=nvim-kickstart nvim
alias mini = ^NVIM_APPNAME=mini nvim
alias packettracer = ^open "/Applications/Cisco Packet Tracer 9.0.0/Cisco Packet Tracer 9.0.app"
alias anim = ^ani-cli
alias anim-c = ^ani-cli -c
alias anim-res = ^ani-cli -q 1080
alias anim-dl = ^ani-cli -d
alias dark = toggle_dark
alias goodnight = ^~/scripts/goodnight.sh

def ntmux [...args: string] {
    if ($args | is-empty) {
        ^zellij attach -c "dan"
    } else {
        ^zellij ...$args
    }
}

alias fetch = ^fastfetch
alias pdf = ^/Applications/sioyek.app/Contents/MacOS/sioyek --new-window
alias vf = ^fzf --preview 'bat --style=numbers --color=always --line-range :500 {}' | xargs -r nvim
alias src = view-source
alias C = pbcopy

# --- MISC UTILITIES ---

# Capture output (Nu version)
def cap [cmd: string, ...args: string] {
    let timestamp = (date now | format date "%Y%m%d_%H%M%S")
    let logfile = $"capture_($timestamp).txt"
    print $"Saving output to ($logfile)..."
    run-external $cmd ...$args | tee { save --force $logfile }
}

# Upscale Aliases (Real-ESRGAN)
let upscale_path = "/Users/dan/projects/pythonVishal/Real-ESRGAN-0.3.0/realesrgan-ncnn-vulkan"
let model_path = "/Users/dan/projects/pythonVishal/Real-ESRGAN-0.3.0/models"
alias upscale = ^$upscale_path -m $model_path -n realesrgan-x4plus
alias upscale-anime = ^$upscale_path -m $model_path -n realesrgan-x4plus-anime

# Todoist (Nu version)
def todo [] {
    ^todo-go list '(today | overdue | #Inbox | recurring)' 
    | fzf --delimiter='\t' --with-nth=2 --header 'Inbox, Today & Recurring: Select to complete (ESC cancel)' --height 40% --reverse 
    | awk '{print $1}' 
    | xargs todo-go close
}

# Display Filters
alias gray = toggle-gray
def toggle-gray [] { ^shortcuts run "Toggle Grayscale" } # Assuming this exists or similar
alias sepia = ^shortcuts run "Sepia Mode"

# --- CUSTOM COMMANDS (FUNCTIONS) ---

# Brave/Firefox URL Handler
def browse [browser: string, keyword?: string, ...query: string] {
    let sites = [
        [aliases, base, search];
        ["youtube|yt", "https://www.youtube.com", "/results?search_query="]
        ["github|gh", "https://github.com", "/search?q="]
        ["linkedin|li", "https://www.linkedin.com", "/search/results/all/?keywords="]
        ["christ|cu", "https://christuniversity.in", ""]
        ["hianime|hi", "https://hianimez.is/home", "https://hianimez.is/search?keyword="]
        ["monkeytype|mt", "https://monkeytype.com", ""]
        ["keybr|kb", "https://www.keybr.com", ""]
        ["greasyfork|gf", "https://greasyfork.org", "/scripts/search?q="]
        ["openjs", "https://openuserjs.org", "/?q="]
        ["classroom|cl", "https://classroom.google.com", ""]
        ["reddit|rd", "https://www.reddit.com", "/search/?q="]
        ["x|twitter", "https://x.com", "/search?q="]
        ["google|g", "https://www.google.com", "/search?q="]
        ["net", "http://192.168.100.100:8090/", ""]
    ]

    if ($keyword | is-empty) {
        ^open -a $browser
        return
    }

    let match = ($sites | where {|s| $"|($s.aliases)|" =~ $"\\|($keyword)\\|" } | first)
    
    if ($match | is-not-empty) {
        if ($query | is-empty) {
            ^open -a $browser $match.base
        } else {
            let q = ($query | str join "+")
            let url = if ($match.search | is-empty) {
                $"($match.base)($q)"
            } else if ($match.search | str starts-with "/") {
                $"($match.base | str replace -r '/$' '')($match.search)($q)"
            } else {
                $"($match.search)($q)"
            }
            ^open -a $browser $url
        }
    } else {
        let url = if ($keyword | str starts-with "http") { $keyword } else { $"https://($keyword)" }
        ^open -a $browser $url
    }
}

def brave [keyword?: string, ...query: string] { browse "Brave Browser" $keyword ...$query }
def fox [keyword?: string, ...query: string] { browse "Firefox" $keyword ...$query }

def --env --wrapped y [...args] {
    let tmp = $"($env.HOME)/.yazi_cwd"
    
    if ("ZELLIJ" in $env) {
        ^env YAZI_CONFIG_HOME=$"($env.HOME)/.config/yazi/zellij" yazi ...$args --cwd-file $tmp
    } else {
        ^yazi ...$args --cwd-file $tmp
    }

    if ($tmp | path exists) {
        let cwd = (open --raw $tmp | str trim)
        if ($cwd | is-not-empty) and ($cwd != $env.PWD) {
            # Explicitly cast to path type to ensure Nushell's 'cd' built-in triggers
            cd ($cwd | into string)
        }
        rm -f $tmp
    }
}

# Kotlin Run
def krun [file: string] {
    let name = ($file | path parse | get stem)
    ^kotlinc $file -include-runtime -d $"($name).temp.jar"
    ^java -jar $"($name).temp.jar"
    rm $"($name).temp.jar"
}

# System Update
def up [] {
    print "🚀 Starting System-wide Update..."
    if (which brew | is-not-empty) { print "🍺 Updating Homebrew..."; ^brew update; ^brew upgrade; ^brew cleanup }
    if (which npm | is-not-empty) { print "📦 Updating npm..."; ^npm install -g npm; ^npm update -g }
    if (which pnpm | is-not-empty) { print "📦 Updating pnpm..."; ^pnpm self-update }
    if (which bun | is-not-empty) { print "🍞 Updating Bun..."; ^bun upgrade }
    if (which deno | is-not-empty) { print "🦕 Updating Deno..."; ^deno upgrade }
    if (which pipx | is-not-empty) { print "🐍 Updating Pipx..."; ^pipx upgrade-all }
    if (which bob | is-not-empty) { print "💤 Updating Neovim..."; ^bob update --all }
    if (which tldr | is-not-empty) { print "📖 Updating tldr..."; ^tldr --update }
    print "✅ System Updated!"
}

# Dark Mode
def toggle_dark [] {
    ^osascript -e "tell application \"System Events\" to tell appearance preferences to set dark mode to not dark mode"
}

# --- COLORS (Catppuccin Macchiato) ---
let catppuccin = {
    rosewater: "#f4dbd6"
    flamingo: "#f0c1ce"
    pink: "#f5bde6"
    mauve: "#c6a0f6"
    red: "#ed8796"
    maroon: "#ee99a0"
    peach: "#f5a97f"
    yellow: "#eed49f"
    green: "#a6da95"
    teal: "#8bd5ca"
    sky: "#91d7e3"
    sapphire: "#7dc4e4"
    blue: "#8aadf4"
    lavender: "#b7bdf8"
    text: "#cad3f5"
    subtext1: "#b8c0e0"
    subtext0: "#a5adcb"
    overlay2: "#939ab7"
    overlay1: "#8087a2"
    overlay0: "#6e738d"
    surface2: "#5b6078"
    surface1: "#494d64"
    surface0: "#363a4f"
    base: "#24273a"
    mantle: "#1e2030"
    crust: "#181926"
}

# Apply Theme to Config
$env.config = {
    show_banner: false
    ls: {
        use_ls_colors: true
        clickable_links: true
    }
    rm: {
        always_trash: true
    }
    table: {
        mode: rounded # Modern look
        index_mode: always
        show_empty: true
    }
    color_config: {
        separator: $catppuccin.overlay0
        leading_trailing_space_bg: { attr: n }
        header: { fg: $catppuccin.blue attr: b }
        empty: $catppuccin.blue
        bool: $catppuccin.peach
        int: $catppuccin.peach
        filesize: $catppuccin.sapphire
        duration: $catppuccin.subtext1
        date: $catppuccin.teal
        range: $catppuccin.peach
        float: $catppuccin.peach
        string: $catppuccin.green
        nothing: $catppuccin.peach
        binary: $catppuccin.peach
        cell-path: $catppuccin.text
        row_index: { fg: $catppuccin.mauve attr: b }
        record: $catppuccin.text
        list: $catppuccin.text
        block: $catppuccin.text
        hints: $catppuccin.overlay1
        search_results: { fg: $catppuccin.base bg: $catppuccin.yellow }

        shape_and: $catppuccin.mauve
        shape_binary: $catppuccin.mauve
        shape_block: $catppuccin.blue
        shape_bool: $catppuccin.teal
        shape_custom: $catppuccin.green
        shape_datetime: $catppuccin.teal
        shape_directory: $catppuccin.blue
        shape_external: $catppuccin.sky
        shape_externalarg: $catppuccin.green
        shape_filepath: $catppuccin.teal
        shape_flag: $catppuccin.sky
        shape_float: $catppuccin.mauve
        shape_garbage: { fg: $catppuccin.text bg: $catppuccin.red }
        shape_globpattern: $catppuccin.teal
        shape_int: $catppuccin.mauve
        shape_internalcall: $catppuccin.sky
        shape_keyword: $catppuccin.mauve
        shape_list: $catppuccin.sky
        shape_literal: $catppuccin.blue
        shape_match_pattern: $catppuccin.green
        shape_matching_brackets: { attr: u }
        shape_nothing: $catppuccin.teal
        shape_operator: $catppuccin.yellow
        shape_or: $catppuccin.mauve
        shape_pipe: $catppuccin.mauve
        shape_range: $catppuccin.yellow
        shape_record: $catppuccin.sky
        shape_redirection: $catppuccin.mauve
        shape_signature: $catppuccin.green
        shape_string: $catppuccin.green
        shape_string_interpolation: $catppuccin.teal
        shape_table: $catppuccin.blue
        shape_variable: $catppuccin.flamingo
        shape_vardecl: $catppuccin.flamingo
    }
    hooks: {
        pre_execution: [
            {
                if ("ZELLIJ" in $env) {
                    let cmd = ($in | default "" | str substring 0..15)
                    if ($cmd | is-not-empty) {
                        ^nohup zellij action rename-tab $cmd out+err> /dev/null
                    }
                }
            }
        ]
        pre_prompt: [
            {
                if ("ZELLIJ" in $env) {
                    let current_dir = ($env.PWD | path parse | get stem)
                    ^nohup zellij action rename-tab $current_dir out+err> /dev/null
                }
            }
        ]
    }
}


$env.config.show_banner = false

$env.config.edit_mode = 'vi'


# --- PLUGINS & SOURCES ---
# source zoxide.nu

# Carapace Completions
$env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense'
mkdir ~/.cache/carapace
^carapace _carapace nushell | save --force ~/.cache/carapace/init.nu
source ~/.cache/carapace/init.nu

# Atuin (Shared History)
source /Users/dan/.cache/atuin/init.nu

# Starship (Prompt)
source /Users/dan/.cache/starship/init.nu

# --- FILE ASSOCIATIONS ---
$env.config.hooks.command_not_found = { |cmd|
    let path = ($cmd | path expand)
    if ($path | path exists) {
        let ext = ($path | path parse).extension
        match $ext {
            "py" | "js" | "ts" | "java" | "cpp" | "c" | "go" | "rs" | "html" | "css" | "sh" => { nvim $path }
            "pdf" => { pdf $path }
            "mp4" | "mov" | "avi" | "mkv" | "mp3" | "wav" | "ogg" => { ^open -a IINA $path }
            _ => { ^open $path }
        }
    } else {
        null
    }
}
