# qol.nu — Quality of life utilities

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

def copy-file-contents [file: string] {
    if ($nu.os-info.name == "macos") { open --raw $file | ^pbcopy } else { open --raw $file | ^xclip -selection clipboard }
    print $"📋 Copied contents of ($file)"
}

def copy-path [] {
    if ($nu.os-info.name == "macos") { $env.PWD | ^pbcopy } else { $env.PWD | ^xclip -selection clipboard }
    print $"📋 Copied: ($env.PWD)"
}

def myip [] {
    let public = (^curl -s ifconfig.me | str trim)
    let local = if ($nu.os-info.name == "macos") { ^ipconfig getifaddr en0 | str trim } else { ^hostname -I | split row " " | first | str trim }
    print $"🌐 Public:  ($public)"
    print $"🏠 Local:   ($local)"
}

def speedtest [] { ^curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | ^python3 - }

def isup [url: string] {
    let target = if ($url | str starts-with "http") { $url } else { $"https://($url)" }
    let code = (^curl -s -o /dev/null -w "%{http_code}" $target | str trim)
    if ($code | str starts-with "2") or ($code | str starts-with "3") { print $"✅ ($target) is UP \(($code)\)" } else { print $"❌ ($target) is DOWN \(($code)\)" }
}

def generate-password [length?: int] { random chars -l ($length | default 24) }

def generate-uuid [] {
    if ($nu.os-info.name == "macos") { ^uuidgen | str lowercase | str trim } else { open /proc/sys/kernel/random/uuid | str trim }
}

def base-64-encode [input: string] { $input | encode base64 }
def base-64-decode [input: string] { $input | decode base64 | decode utf-8 }

def json-prettier [] {
    if ($nu.os-info.name == "macos") { ^pbpaste | from json | to json -i 2 } else { ^xclip -selection clipboard -o | from json | to json -i 2 }
}

def --env proj [name: string, template?: string] {
    let tmpl = ($template | default "basic")
    mkdir $name; cd $name
    match $tmpl {
        "basic" => { touch README.md; "# " + $name | save README.md; ^git init }
        "node" => { ^npm init -y; ^git init; ".node_modules/\n.env\ndist/" | save .gitignore }
        "python" => { ^git init; mkdir src tests; touch src/__init__.py; "venv/\n__pycache__/\n*.pyc\n.env" | save .gitignore; ^python3 -m venv venv }
        _ => { ^git init; touch README.md }
    }
    print $"📁 Project ($name) created with ($tmpl) template"
}

def bak [file: string] {
    let timestamp = (date now | format date "%Y%m%d_%H%M%S")
    let backup = $"($file).($timestamp).bak"
    cp $file $backup
    print $"💾 Backed up to ($backup)"
}

def note [action?: string, ...content: string] {
    let notes_file = ([$env.HOME ".notes.md"] | path join)
    match ($action | default "show") {
        "add" => { let text = ($content | str join " "); let ts = (date now | format date "%Y-%m-%d %H:%M"); $"\n- [($ts)] ($text)" | save --append $notes_file; print "📝 Note added" }
        "edit" => { ^nvim $notes_file }
        "clear" => { "" | save --force $notes_file; print "🗑️ Notes cleared" }
        "show" | _ => { if ($notes_file | path exists) { open --raw $notes_file } else { print "📭 No notes yet. Use: note add <text>" } }
    }
}

def sshf [] {
    let host = (open ~/.ssh/config | lines | where {|l| $l =~ "^Host " } | each {|l| $l | str replace "Host " "" | str trim } | str join "\n" | ^fzf --header 'SSH to:' --height 40% --reverse | str trim)
    if ($host | is-not-empty) { ^ssh $host }
}

def serve [port?: int] {
    let p = ($port | default 8080)
    print $"🌐 Serving ($env.PWD) on http://localhost:($p)"
    if (which python3 | is-not-empty) { ^python3 -m http.server $p } else if (which npx | is-not-empty) { ^npx serve -l $p } else { print "❌ Need python3 or npx" }
}

def ports [] { ^lsof -iTCP -sTCP:LISTEN -n -P | lines | skip 1 | parse "{cmd} {pid} {user} {rest}" }

def extract [file: string] {
    match ($file | path parse | get extension | str lowercase) {
        "zip" => { ^unzip $file }
        "tar" | "gz" | "tgz" | "xz" | "bz2" => { ^tar xf $file }
        "7z" => { ^7z x $file }
        "rar" => { ^unrar x $file }
        _ => { print $"Unknown format: ($file)" }
    }
}

def fkill [] {
    let pid = (^ps aux | ^fzf --header 'Select process to kill' --height 40% | awk '{print $2}' | str trim)
    if ($pid | is-not-empty) { kill ($pid | into int) }
}

def cheat [query: string] { ^curl -s $"cheat.sh/($query)" }
