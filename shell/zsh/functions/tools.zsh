# tools.zsh — cap, vf, krun, pdf, open override, todo

# Capture output of a command to a timestamped file
cap() {
    local timestamp=$(date +%Y%m%d_%H%M%S)
    local logfile="capture_${timestamp}.txt"
    echo "Saving output to $logfile ..."
    "$@" |& tee "$logfile"
}

# Fuzzy find & edit
vf() {
    local file
    file=$(fzf --preview 'bat --style=numbers --color=always --line-range :500 {}')
    if [[ -n $file ]]; then
        $EDITOR "$file"
    fi
}

# Kotlin compile, run, cleanup
krun() {
    if [[ -z "$1" ]]; then
        echo "Usage: krun <file.kt>"
        return 1
    fi
    local file="$1"
    local name="${file%.*}"
    kotlinc "$file" -include-runtime -d "${name}.temp.jar" && \
    java -jar "${name}.temp.jar" && \
    rm "${name}.temp.jar"
}

# Open PDF in Sioyek (new window)
pdf() {
    /Applications/sioyek.app/Contents/MacOS/sioyek --new-window "$@" &> /dev/null &|
}

# Todoist interactive
todo() {
    todo-go list '(today | overdue | #Inbox | recurring)' \
        | fzf --delimiter='\t' --with-nth=2 \
            --header 'Inbox, Today & Recurring: Select to complete (ESC cancel)' \
            --height 40% --reverse \
        | awk '{print $1}' \
        | xargs todo-go close
}

# Thefuck — lazy-loaded
fuck() {
    unfunction fuck
    eval "$(thefuck --alias)"
    fuck "$@"
}

# File association dispatcher (overrides system open)
open() {
    if [[ $# -eq 0 ]]; then
        /usr/bin/open .
        return
    fi

    local target="$1"
    if [[ ! -f "$target" && $# -gt 1 && -f "$*" ]]; then
        target="$*"
    fi

    if [[ -f "$target" ]]; then
        local ext="${target##*.}"
        case "${ext:l}" in
            py|js|ts|java|cpp|c|go|rs|css|sh|nu|toml|yaml|yml|json|md|lua|rb|zig|swift|kt)
                nvim "$target"
                ;;
            pdf)
                /usr/bin/open -a sioyek "$target"
                ;;
            html|htm)
                /usr/bin/open "$target"
                ;;
            mp4|mov|avi|mkv|mp3|wav|ogg|flac|webm|m4a)
                /usr/bin/open -a IINA "$target"
                ;;
            png|jpg|jpeg|gif|webp|bmp|tiff|svg)
                /usr/bin/open "$target"
                ;;
            docx|doc|xlsx|xls|pptx|ppt|csv|rtf)
                /usr/bin/open "$target"
                ;;
            epub)
                /usr/bin/open -a Books "$target"
                ;;
            *)
                /usr/bin/open "$target"
                ;;
        esac
        return 0
    else
        echo "zsh: no such file or directory: $target"
        return 1
    fi
}

# Universal home directory fuzzy finder (Ctrl+F widget)
fzf-universal-file-widget() {
    local cmd
    if command -v fd &>/dev/null; then
        cmd="fd --type f --hidden --follow --exclude .git --exclude Library --exclude .cache --exclude node_modules --exclude .cargo --exclude .npm . ~"
    else
        cmd="find ~ -type f -not -path '*/.*' 2>/dev/null"
    fi

    local file=$(eval "$cmd" | fzf --preview 'sh -c "bat --style=numbers --color=always --line-range :500 \"$1\" 2>/dev/null || cat \"$1\" 2>/dev/null" -- {}')

    if [[ -n "$file" ]]; then
        LBUFFER="${LBUFFER}${file}"
    fi
    zle reset-prompt
}

zle -N fzf-universal-file-widget
bindkey '^F' fzf-universal-file-widget

# Real-ESRGAN upscaler
# Usage: upscale [flags] <input> [input...]
#   --anime          anime/illustration model (realesrgan-x4plus-anime)
#   --anime-video    fast anime video model (realesr-animevideov3)
#   --photo          general photo model (realesrgan-x4plus, default)
#   --2x / --3x / --4x   scale factor (default: 4x)
#   -o <path>        output path (file or directory)
#   -f <fmt>         output format: png/jpg/webp (default: png)
#   -t <size>        tile size (0=auto, lower = less VRAM)
#   -v               verbose
upscale() {
    local ESRGAN_DIR="$HOME/projects/pythonVishal/Real-ESRGAN-0.3.0"
    local BIN="$ESRGAN_DIR/realesrgan-ncnn-vulkan"
    local MODELS="$ESRGAN_DIR/models"

    if [[ ! -x "$BIN" ]]; then
        echo "upscale: binary not found at $BIN" >&2
        return 1
    fi

    local model="realesrgan-x4plus"
    local scale="" output="" format="" tile="" verbose=""

    while [[ $# -gt 0 ]]; do
        case "$1" in
            --anime)        model="realesrgan-x4plus-anime"; shift ;;
            --anime-video)  model="realesr-animevideov3"; shift ;;
            --photo)        model="realesrgan-x4plus"; shift ;;
            --2x)           scale=2; shift ;;
            --3x)           scale=3; shift ;;
            --4x)           scale=4; shift ;;
            -o)             output="$2"; shift 2 ;;
            -f)             format="$2"; shift 2 ;;
            -t)             tile="$2"; shift 2 ;;
            -v)             verbose="-v"; shift ;;
            --)             shift; break ;;
            -*)             echo "upscale: unknown flag $1" >&2; return 1 ;;
            *)              break ;;
        esac
    done

    if [[ $# -eq 0 ]]; then
        echo "Usage: upscale [flags] <input> [input...]" >&2
        echo "" >&2
        echo "Models:" >&2
        echo "  --photo          general photos (default)" >&2
        echo "  --anime          anime / illustrations" >&2
        echo "  --anime-video    fast anime video" >&2
        echo "" >&2
        echo "Scale:  --2x  --3x  --4x (default: 4x)" >&2
        echo "Output: -o <path>  -f <format>  -t <tile>  -v" >&2
        return 1
    fi

    local sfx="_${scale:-4}x"

    for input in "$@"; do
        local auto_out=""
        if [[ -z "$output" ]]; then
            if [[ -d "$input" ]]; then
                auto_out="${input%/}_upscaled"
            else
                local dir="$(dirname "$input")"
                local base="$(basename "$input")"
                local name="${base%.*}"
                local ext="${base##*.}"
                [[ "$base" == *.* ]] && auto_out="$dir/${name}${sfx}.$ext" || auto_out="$input${sfx}"
            fi
        fi

        echo "upscale [$model] $input -> ${auto_out:-$output}"
        command "$BIN" \
            -m "$MODELS" -n "$model" \
            ${scale:+-s "$scale"} \
            -o "${auto_out:-$output}" \
            ${format:+-f "$format"} \
            ${tile:+-t "$tile"} \
            $verbose \
            -i "$input"
    done
}
