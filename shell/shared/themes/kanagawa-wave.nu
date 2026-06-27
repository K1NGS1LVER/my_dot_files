# Kanagawa Wave — Nushell color palette + FZF theme
# Identical palette to kanagawa-wave.zsh — do not edit one without the other.
# Defines constant named `catppuccin` for compatibility with existing config.nu.

const catppuccin = {
    rosewater: "#ffa066"
    flamingo:  "#938aa9"
    pink:      "#938aa9"
    mauve:     "#957fb8"
    red:       "#c3404b"
    maroon:    "#c3404b"
    peach:     "#ffa066"
    yellow:    "#c0a36e"
    green:     "#76946a"
    teal:      "#6a9589"
    sky:       "#7aa89f"
    sapphire:  "#7fb4ca"
    blue:      "#7e9cd8"
    lavender:  "#938aa9"
    text:      "#dcd7ba"
    subtext1:  "#dcd7ba"
    subtext0:  "#a89984"
    overlay2:  "#727169"
    overlay1:  "#727169"
    overlay0:  "#54546d"
    surface2:  "#2d4f67"
    surface1:  "#2d4f67"
    surface0:  "#2d4f67"
    base:      "#1f1f28"
    mantle:    "#16161d"
    crust:     "#0f0f14"
}

# FZF theme string (Kanagawa Wave) — set as env var for fzf
$env.FZF_DEFAULT_OPTS = ([
    $"--color=bg+:($catppuccin.surface0),bg:($catppuccin.base),spinner:($catppuccin.teal),hl:($catppuccin.red)"
    $"--color=fg:($catppuccin.text),header:($catppuccin.red),info:($catppuccin.mauve),pointer:($catppuccin.teal)"
    $"--color=marker:($catppuccin.teal),fg+:($catppuccin.text),prompt:($catppuccin.mauve),hl+:($catppuccin.red)"
] | str join " ")
