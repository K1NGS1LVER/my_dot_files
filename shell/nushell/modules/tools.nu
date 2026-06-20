# tools.nu — cap, vf, krun, pdf, smart-open, upscale, todo, neovim profiles

def cap [cmd: string, ...args: string] {
    let timestamp = (date now | format date "%Y%m%d_%H%M%S")
    let logfile = $"capture_($timestamp).txt"
    print $"Saving output to ($logfile)..."
    ^$cmd ...$args | tee { save --force $logfile }
}

def vf [] {
    let file = (^fzf --preview 'bat --style=numbers --color=always --line-range :500 {}' | str trim)
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

# File association dispatcher (overrides Nushell's open)
def smart-open [cmd_name: string, --raw (-r)] {
    if $raw {
        return (^open --raw $cmd_name)
    }

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
