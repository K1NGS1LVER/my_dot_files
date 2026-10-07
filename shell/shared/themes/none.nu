# None — plain terminal, no theme/accent colors
# Nushell's config.nu unconditionally reads `$catppuccin.*` for its own
# structured-output color_config (shape_*, table cell colors, etc.) - unlike
# zsh, there is no way to just omit this and let nu fall back to "no color".
# So every semantic slot here is mapped onto the same plain xterm 16-color
# set already used by kitty/ghostty/alacritty/none.zsh for this theme - no
# new colors are invented, this is the closest thing to "no theme" nu allows.
# Identical mapping intent to none.zsh — do not add a real accent palette to
# one without discussing the other.

const catppuccin = {
    rosewater: "#f2dca4"
    flamingo:  "#e69a83"
    pink:      "#c6a5c2"
    mauve:     "#b48ead"
    red:       "#d08770"
    maroon:    "#d08770"
    peach:     "#e69a83"
    yellow:    "#ebcb8b"
    green:     "#a3be8c"
    teal:      "#88c0d0"
    sky:       "#9dd6e3"
    sapphire:  "#88c0d0"
    blue:      "#81a1c1"
    lavender:  "#9bbbd8"
    text:      "#d8dee9"
    subtext1:  "#d8dee9"
    subtext0:  "#4c566a"
    overlay2:  "#4c566a"
    overlay1:  "#4c566a"
    overlay0:  "#4c566a"
    surface2:  "#4c566a"
    surface1:  "#2e3440"
    surface0:  "#2e3440"
    base:      "#1f2430"
    mantle:    "#1f2430"
    crust:     "#1f2430"
}

$env.BAT_THEME = "ansi"
