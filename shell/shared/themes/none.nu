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
    rosewater: "#ff0000"
    flamingo:  "#cd00cd"
    pink:      "#cd00cd"
    mauve:     "#cd00cd"
    red:       "#cd0000"
    maroon:    "#cd0000"
    peach:     "#ff0000"
    yellow:    "#cdcd00"
    green:     "#00cd00"
    teal:      "#00cdcd"
    sky:       "#00cdcd"
    sapphire:  "#00cdcd"
    blue:      "#0000ee"
    lavender:  "#cd00cd"
    text:      "#e5e5e5"
    subtext1:  "#e5e5e5"
    subtext0:  "#7f7f7f"
    overlay2:  "#7f7f7f"
    overlay1:  "#7f7f7f"
    overlay0:  "#7f7f7f"
    surface2:  "#3c3c3c"
    surface1:  "#3c3c3c"
    surface0:  "#3c3c3c"
    base:      "#000000"
    mantle:    "#000000"
    crust:     "#000000"
}

$env.BAT_THEME = "ansi"
