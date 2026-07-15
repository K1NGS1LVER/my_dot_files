# browser.zsh — Smart browser launcher (brave/fox/wolf)
# Depends on: shell/shared/browser-sites.zsh (sourced before this file)

_open_browser() {
    local browser="$1"; shift

    if [[ -z "$1" ]]; then
        open -a "$browser"
        return
    fi

    local keyword="$1"; shift

    for site in "${_BROWSER_SITES[@]}"; do
        local aliases="${site%%;*}"
        local rest="${site#*;}"
        local base="${rest%%;*}"
        local search_path="${rest#*;}"

        if [[ "|${aliases}|" == *"|${keyword}|"* ]]; then
            if [[ -z "$@" ]]; then
                open -a "$browser" "$base"
            else
                local query=$(printf "%s+" "$@")
                query=${query%+}
                if [[ -n "$search_path" && "$search_path" != "$base" ]]; then
                    if [[ "$search_path" == /* ]]; then
                        open -a "$browser" "${base%/}${search_path}${query}"
                    else
                        open -a "$browser" "${search_path}${query}"
                    fi
                else
                    open -a "$browser" "${base}${query}"
                fi
            fi
            return
        fi
    done

    if [[ "$keyword" != http* ]]; then
        open -a "$browser" "https://$keyword"
    else
        open -a "$browser" "$keyword"
    fi
}

brave() { _open_browser "Brave Browser" "$@"; }
fox() { _open_browser "Firefox" "$@"; }
wolf() { _open_browser "LibreWolf" "$@"; }
