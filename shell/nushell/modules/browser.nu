# browser.nu — Unified browser URL handler (brave/fox/wolf)

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
