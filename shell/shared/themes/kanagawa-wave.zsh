# Kanagawa Wave — Zsh color palette + FZF theme + syntax highlighting
# Identical palette to kanagawa-wave.nu — do not edit one without the other.

export BAT_THEME="base16"

# --- Palette Exports ---
export KANAGAWA_BG="#1f1f28"
export KANAGAWA_FG="#dcd7ba"
export KANAGAWA_COMMENT="#727169"
export KANAGAWA_RED="#c3404b"
export KANAGAWA_GREEN="#76946a"
export KANAGAWA_YELLOW="#c0a36e"
export KANAGAWA_BLUE="#7e9cd8"
export KANAGAWA_PURPLE="#957fb8"
export KANAGAWA_CYAN="#6a9589"
export KANAGAWA_SELECTION="#2d4f67"

# --- FZF Theme (Kanagawa Wave) ---
export FZF_DEFAULT_OPTS=" \
--color=bg+:$KANAGAWA_SELECTION,bg:$KANAGAWA_BG,spinner:$KANAGAWA_CYAN,hl:$KANAGAWA_RED \
--color=fg:$KANAGAWA_FG,header:$KANAGAWA_RED,info:$KANAGAWA_PURPLE,pointer:$KANAGAWA_CYAN \
--color=marker:$KANAGAWA_CYAN,fg+:$KANAGAWA_FG,prompt:$KANAGAWA_PURPLE,hl+:$KANAGAWA_RED"

# --- Zsh Syntax Highlighting Styles ---
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[command]='fg=#7e9cd8'
ZSH_HIGHLIGHT_STYLES[alias]='fg=#76946a'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=#7e9cd8'
ZSH_HIGHLIGHT_STYLES[function]='fg=#76946a'
ZSH_HIGHLIGHT_STYLES[keyword]='fg=#957fb8'
ZSH_HIGHLIGHT_STYLES[string]='fg=#c0a36e'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=#ffa066'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=#ffa066'
ZSH_HIGHLIGHT_STYLES[path]='fg=#dcd7ba'
ZSH_HIGHLIGHT_STYLES[path_prefix]='fg=#dcd7ba'
ZSH_HIGHLIGHT_STYLES[path_approx]='fg=#dcd7ba'
ZSH_HIGHLIGHT_STYLES[globbing]='fg=#957fb8'
