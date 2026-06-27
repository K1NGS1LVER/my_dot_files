# Tokyo Night Storm — Nushell color palette + FZF theme
# Identical palette to tokyonight-storm.zsh — do not edit one without the other.
# Defines constant named `catppuccin` for compatibility with existing config.nu.

const catppuccin = {
    rosewater: "#ff9e64"
    flamingo:  "#bb9af7"
    pink:      "#bb9af7"
    mauve:     "#bb9af7"
    red:       "#f7768e"
    maroon:    "#f7768e"
    peach:     "#ff9e64"
    yellow:    "#e0af68"
    green:     "#9ece6a"
    teal:      "#7dcfff"
    sky:       "#7dcfff"
    sapphire:  "#7aa2f7"
    blue:      "#7aa2f7"
    lavender:  "#bb9af7"
    text:      "#a9b1d6"
    subtext1:  "#a9b1d6"
    subtext0:  "#a9b1d6"
    overlay2:  "#565f89"
    overlay1:  "#565f89"
    overlay0:  "#414868"
    surface2:  "#343b58"
    surface1:  "#343b58"
    surface0:  "#343b58"
    base:      "#24283b"
    mantle:    "#1f2335"
    crust:     "#1d202f"
}

# FZF theme string (Tokyo Night Storm) — set as env var for fzf
$env.FZF_DEFAULT_OPTS = ([
    $"--color=bg+:($catppuccin.surface0),bg:($catppuccin.base),spinner:($catppuccin.teal),hl:($catppuccin.red)"
    $"--color=fg:($catppuccin.text),header:($catppuccin.red),info:($catppuccin.mauve),pointer:($catppuccin.teal)"
    $"--color=marker:($catppuccin.teal),fg+:($catppuccin.text),prompt:($catppuccin.mauve),hl+:($catppuccin.red)"
] | str join " ")
