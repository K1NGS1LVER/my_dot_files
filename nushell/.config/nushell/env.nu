# env.nu - Nushell Environment Configuration (0.110.0)

# Path setup (Nu uses a list for paths)
$env.PATH = (
    $env.PATH 
    | split row (char esep) 
    | append [
        ($env.HOME | path join ".local" "bin")
        ($env.HOME | path join ".cargo" "bin")
        "/opt/homebrew/bin"
        "/opt/homebrew/sbin"
        "/usr/local/bin"
        "/opt/homebrew/opt/openjdk/bin"
        ($env.HOME | path join "Library" "pnpm")
        ($env.HOME | path join ".local" "share" "bob" "nvim-bin")
        ($env.HOME | path join ".local" "share" "nvim" "mason" "bin")
        "/Applications/Android Studio.app/Contents/MacOS"
    ]
    | uniq
)

# Environment Variables
$env.EDITOR = "nvim"
$env.JAVA_HOME = (^/usr/libexec/java_home | str trim)
$env.MANPAGER = "sh -c 'col -bx | bat -l man -p'"
$env.BAT_THEME = "Catppuccin Macchiato"
$env.LYNX_CFG = ($env.HOME | path join ".lynx.cfg")
$env.LYNX_LSS = ($env.HOME | path join ".lynx.lss")
$env.YAZI_TRT = "5000"
$env.PNPM_HOME = ($env.HOME | path join "Library" "pnpm")

# Carapace Bridges
$env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense'
