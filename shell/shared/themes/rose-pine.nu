# Rose Pine — Nushell color palette + FZF theme
# Identical palette to rose-pine.zsh — do not edit one without the other.
# Defines constant named `catppuccin` for compatibility with existing config.nu.

const catppuccin = {
    rosewater: "#ebbcba"
    flamingo:  "#eb6f92"
    pink:      "#eb6f92"
    mauve:     "#c4a7e7"
    red:       "#eb6f92"
    maroon:    "#eb6f92"
    peach:     "#f6c177"
    yellow:    "#f6c177"
    green:     "#31748f"
    teal:      "#9ccfd8"
    sky:       "#9ccfd8"
    sapphire:  "#9ccfd8"
    blue:      "#9ccfd8"
    lavender:  "#c4a7e7"
    text:      "#e0def4"
    subtext1:  "#e0def4"
    subtext0:  "#908caa"
    overlay2:  "#908caa"
    overlay1:  "#908caa"
    overlay0:  "#524f67"
    surface2:  "#403d52"
    surface1:  "#403d52"
    surface0:  "#403d52"
    base:      "#191724"
    mantle:    "#1f1d2e"
    crust:     "#12101a"
}

# FZF theme string (Rose Pine) — set as env var for fzf
$env.FZF_DEFAULT_OPTS = ([
    $"--color=bg+:($catppuccin.surface0),bg:($catppuccin.base),spinner:($catppuccin.teal),hl:($catppuccin.red)"
    $"--color=fg:($catppuccin.text),header:($catppuccin.red),info:($catppuccin.mauve),pointer:($catppuccin.teal)"
    $"--color=marker:($catppuccin.teal),fg+:($catppuccin.text),prompt:($catppuccin.mauve),hl+:($catppuccin.red)"
] | str join " ")
