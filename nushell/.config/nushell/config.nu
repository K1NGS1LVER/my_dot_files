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

def nv-kick [] {
    $env.NVIM_APPNAME = "nvim-kickstart"
    ^nvim
}

def nv-play [] {
    $env.NVIM_APPNAME = "nvim-playground"
    let bob_bin = ([$env.HOME ".local" "share" "bob" "nightly" "bin" "nvim"] | path join)
    ^$bob_bin
}

def mini [] {
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

def ntmux [...args: string] {
    if ($args | is-empty) {
        ^zellij attach -c "dan"
    } else {
        ^zellij ...$args
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
        ["🐍 Pipx",      "pipx",  [["pipx" "upgrade-all"]]]
        ["💤 Neovim",    "bob",   [["bob" "update" "--all"]]]
        ["📖 tldr",      "tldr",  [["tldr" "--update"]]]
    ]

    for tool in $tools {
        if (which $tool.check | is-not-empty) {
            print $"($tool.name)..."
            for cmd in $tool.cmds {
                let bin = ($cmd | first)
                let cmd_args = ($cmd | skip 1)
                ^$bin ...$cmd_args
            }
        }
    }

    print "✅ System updated!"
}

# ─────────────────────────────────────────────
# DARK MODE TOGGLE
# ─────────────────────────────────────────────

def toggle_dark [] {
    if ($nu.os-info.name == "macos") {
        ^osascript -e 'tell application "System Events" to tell appearance preferences to set dark mode to not dark mode'
    } else {
        print "Dark mode toggle not supported on this platform."
    }
}

# ─────────────────────────────────────────────
# PDF VIEWER
# ─────────────────────────────────────────────

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
        mode: rounded
        index_mode: always
        show_empty: false
    }

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
    algorithm: "fuzzy"    # prefix or fuzzy
    external: {
        enable: true       # set to false to disable external completions
        max_results: 100   # maximum number of results to return from external completers
    }
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
# FILE ASSOCIATIONS — command_not_found hook
# ─────────────────────────────────────────────

$env.config.hooks.command_not_found = {|cmd_name|
    let filepath = ($cmd_name | path expand)
    if not ($filepath | path exists) { return null }

    let parsed = ($filepath | path parse)
    let ext = ($parsed.extension | str downcase)

    let editor_exts = ["py" "js" "ts" "java" "cpp" "c" "go" "rs" "html" "css" "sh" "nu" "toml" "yaml" "yml" "json" "md" "lua" "rb" "zig" "swift" "kt"]
    let media_exts  = ["mp4" "mov" "avi" "mkv" "mp3" "wav" "ogg" "flac" "webm" "m4a"]

    let is_mac = ($nu.os-info.name == "macos")

    if ($ext in $editor_exts) {
        ^nvim $filepath
    } else if ($ext == "pdf") {
        if $is_mac { ^open -a sioyek $filepath } else { ^xdg-open $filepath }
    } else if ($ext in $media_exts) {
        if $is_mac { ^open -a IINA $filepath } else { ^xdg-open $filepath }
    } else {
        if $is_mac { ^open $filepath } else { ^xdg-open $filepath }
    }
}

# ─────────────────────────────────────────────
# PLUGINS & EXTERNAL SOURCES
# ─────────────────────────────────────────────

# Carapace completions
$env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense'
let carapace_cache = ([$env.HOME ".cache" "carapace"] | path join)
mkdir $carapace_cache
^carapace _carapace nushell | save --force ($carapace_cache | path join "init.nu")
source ~/.cache/carapace/init.nu

# Atuin (shared history)
source ~/.cache/atuin/init.nu

# Starship (prompt)
source ~/.cache/starship/init.nu

# Zoxide
source ./zoxide.nu
