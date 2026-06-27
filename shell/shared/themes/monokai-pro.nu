# Monokai Pro — Nushell color palette + FZF theme
# Identical palette to monokai-pro.zsh — do not edit one without the other.
# Defines constant named `catppuccin` for compatibility with existing config.nu.

const catppuccin = {
    rosewater: "#fc9867"
    flamingo:  "#ff6188"
    pink:      "#ff6188"
    mauve:     "#ab9df2"
    red:       "#ff6188"
    maroon:    "#ff6188"
    peach:     "#fc9867"
    yellow:    "#ffd866"
    green:     "#a9dc76"
    teal:      "#78dce8"
    sky:       "#78dce8"
    sapphire:  "#78dce8"
    blue:      "#78dce8"
    lavender:  "#ab9df2"
    text:      "#fcfcfa"
    subtext1:  "#fcfcfa"
    subtext0:  "#908e8f"
    overlay2:  "#727072"
    overlay1:  "#727072"
    overlay0:  "#5b595c"
    surface2:  "#403e41"
    surface1:  "#403e41"
    surface0:  "#403e41"
    base:      "#2d2a2e"
    mantle:    "#221f22"
    crust:     "#19181a"
}

# FZF theme string (Monokai Pro) — set as env var for fzf
$env.FZF_DEFAULT_OPTS = ([
    $"--color=bg+:($catppuccin.surface0),bg:($catppuccin.base),spinner:($catppuccin.rosewater),hl:($catppuccin.red)"
    $"--color=fg:($catppuccin.text),header:($catppuccin.red),info:($catppuccin.mauve),pointer:($catppuccin.rosewater)"
    $"--color=marker:($catppuccin.rosewater),fg+:($catppuccin.text),prompt:($catppuccin.mauve),hl+:($catppuccin.red)"
] | str join " ")
