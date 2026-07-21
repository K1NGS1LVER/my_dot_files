# tools.nu — cap, vf, krun, pdf, smart-open, upscale, todo, neovim profiles

def cap [cmd: string, ...args: string] {
    let timestamp = (date now | format date "%Y%m%d_%H%M%S")
    let logfile = $"capture_($timestamp).txt"
    print $"Saving output to ($logfile)..."
    ^$cmd ...$args | tee { save --force $logfile }
}

def vf [] {
    let file = (^fzf --preview 'bat --style=numbers --color=always --line-range :500 {} 2>/dev/null || cat {} 2>/dev/null' | str trim)
    if ($file | is-not-empty) {
        ^nvim $file
    }
}

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

def pdf [...args: string] {
    if ($nu.os-info.name == "macos") {
        ^open -a sioyek --new-window ...$args
    } else {
        ^sioyek --new-window ...$args
    }
}

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

# Neovim profiles
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

# Upscale (Real-ESRGAN)
def upscale [
    --anime (-a)          # anime/illustration model
    --anime-video (-V)    # fast anime video model
    --photo (-p)          # general photo model (default)
    --two-x               # 2x scale
    --three-x             # 3x scale
    --four-x              # 4x scale (default)
    --output (-o): string # output path
    --format (-f): string # output format: png/jpg/webp
    --tile (-t): string   # tile size (0=auto)
    --verbose (-v)        # verbose output
    ...args: string       # input file(s) or directory
] {
    let upscale_dir = ([$env.HOME "projects" "pythonVishal" "Real-ESRGAN-0.3.0"] | path join)
    let bin = ([$upscale_dir "realesrgan-ncnn-vulkan"] | path join)
    let models = ([$upscale_dir "models"] | path join)

    if not ($bin | path exists) {
        print $"(ansi red)upscale: binary not found at ($bin)(ansi reset)"
        return
    }

    let model = if $anime { "realesrgan-x4plus-anime" }
        else if $anime_video { "realesr-animevideov3" }
        else { "realesrgan-x4plus" }

    let scale = if $two_x { "2" } else if $three_x { "3" } else if $four_x { "4" } else { null }
    let sfx = $"_($scale | default '4')x"

    for input in $args {
        let parsed = ($input | path parse)
        let ext = if ($parsed.extension | is-not-empty) { $parsed.extension } else { "png" }
        let auto_out = if ($output | is-not-empty) { $output }
            else if ($input | path exists) and ($input | path type) == "dir" { $"($input)_upscaled" }
            else { $"($parsed.parent)/($parsed.stem)($sfx).($ext)" }

        print $"upscale [($model)] ($input) -> ($auto_out)"
        let cmd_args = [
            "-m" $models
            "-n" $model
            "-i" $input
            "-o" $auto_out
        ]

        let cmd_args = if $scale != null { $cmd_args | append ["-s" $scale] } else { $cmd_args }
        let cmd_args = if ($format | is-not-empty) { $cmd_args | append ["-f" $format] } else { $cmd_args }
        let cmd_args = if ($tile | is-not-empty) { $cmd_args | append ["-t" $tile] } else { $cmd_args }
        let cmd_args = if $verbose { $cmd_args | append "-v" } else { $cmd_args }

        ^$bin ...$cmd_args
    }
}

# File association dispatcher (overrides Nushell's open)
def smart-open [cmd_name: string, --raw (-r)] {
    if $raw {
        return (^open --raw $cmd_name)
    }

    let filepath = ($cmd_name | path expand)
    if not ($filepath | path exists) {
        print $"(ansi red)Error: File not found: ($cmd_name)(ansi reset)"
        return }

    let parsed = ($filepath | path parse)
    let ext = ($parsed.extension | str lowercase)

    let editor_exts = ["py" "js" "ts" "java" "cpp" "c" "go" "rs" "css" "sh" "nu" "toml" "yaml" "yml" "json" "md" "lua" "rb" "zig" "swift" "kt"]
    let media_exts  = ["mp4" "mov" "avi" "mkv" "mp3" "wav" "ogg" "flac" "webm" "m4a"]
    let image_exts  = ["png" "jpg" "jpeg" "gif" "webp" "bmp" "tiff" "svg"]
    let doc_exts    = ["docx" "doc" "xlsx" "xls" "pptx" "ppt" "csv" "rtf"]

    let is_mac = ($nu.os-info.name == "macos")

    if ($ext in $editor_exts) {
        ^nvim $filepath
    } else if ($ext == "pdf") {
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
