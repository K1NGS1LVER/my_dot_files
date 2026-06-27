# Gruvbox Dark — Nushell color palette + FZF theme
# Identical palette to gruvbox-dark.zsh — do not edit one without the other.
# Defines constant named `catppuccin` for compatibility with existing config.nu.

const catppuccin = {
    rosewater: "#fe8019"
    flamingo:  "#d3869b"
    pink:      "#d3869b"
    mauve:     "#d3869b"
    red:       "#fb4934"
    maroon:    "#fb4934"
    peach:     "#fe8019"
    yellow:    "#fabd2f"
    green:     "#b8bb26"
    teal:      "#8ec07c"
    sky:       "#8ec07c"
    sapphire:  "#83a598"
    blue:      "#83a598"
    lavender:  "#d3869b"
    text:      "#ebdbb2"
    subtext1:  "#ebdbb2"
    subtext0:  "#a89984"
    overlay2:  "#928374"
    overlay1:  "#928374"
    overlay0:  "#665c54"
    surface2:  "#504945"
    surface1:  "#504945"
    surface0:  "#504945"
    base:      "#282828"
    mantle:    "#1d2021"
    crust:     "#151718"
}

# FZF theme string (Gruvbox Dark) — set as env var for fzf
$env.FZF_DEFAULT_OPTS = ([
    $"--color=bg+:($catppuccin.surface0),bg:($catppuccin.base),spinner:($catppuccin.teal),hl:($catppuccin.red)"
    $"--color=fg:($catppuccin.text),header:($catppuccin.red),info:($catppuccin.mauve),pointer:($catppuccin.teal)"
    $"--color=marker:($catppuccin.teal),fg+:($catppuccin.text),prompt:($catppuccin.mauve),hl+:($catppuccin.red)"
] | str join " ")
