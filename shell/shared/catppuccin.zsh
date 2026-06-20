# Catppuccin Macchiato — Zsh color palette + FZF theme + syntax highlighting
# Identical palette to catppuccin.nu — do not edit one without the other.

# --- Palette Exports ---
export CATPPUCCIN_ROSEWATER="#f4dbd6"
export CATPPUCCIN_FLAMINGO="#f0c1ce"
export CATPPUCCIN_PINK="#f5bde6"
export CATPPUCCIN_MAUVE="#c6a0f6"
export CATPPUCCIN_RED="#ed8796"
export CATPPUCCIN_MAROON="#ee99a0"
export CATPPUCCIN_PEACH="#f5a97f"
export CATPPUCCIN_YELLOW="#eed49f"
export CATPPUCCIN_GREEN="#a6da95"
export CATPPUCCIN_TEAL="#8bd5ca"
export CATPPUCCIN_SKY="#91d7e3"
export CATPPUCCIN_SAPPHIRE="#7dc4e4"
export CATPPUCCIN_BLUE="#8aadf4"
export CATPPUCCIN_LAVENDER="#b7bdf8"
export CATPPUCCIN_TEXT="#cad3f5"
export CATPPUCCIN_SUBTEXT1="#b8c0e0"
export CATPPUCCIN_SUBTEXT0="#a5adcb"
export CATPPUCCIN_OVERLAY2="#939ab7"
export CATPPUCCIN_OVERLAY1="#8087a2"
export CATPPUCCIN_OVERLAY0="#6e738d"
export CATPPUCCIN_SURFACE2="#5b6078"
export CATPPUCCIN_SURFACE1="#494d64"
export CATPPUCCIN_SURFACE0="#363a4f"
export CATPPUCCIN_BASE="#24273a"
export CATPPUCCIN_MANTLE="#1e2030"
export CATPPUCCIN_CRUST="#181926"

# --- FZF Theme (Catppuccin Macchiato) ---
export FZF_DEFAULT_OPTS=" \
--color=bg+:$CATPPUCCIN_SURFACE0,bg:$CATPPUCCIN_BASE,spinner:$CATPPUCCIN_ROSEWATER,hl:$CATPPUCCIN_RED \
--color=fg:$CATPPUCCIN_TEXT,header:$CATPPUCCIN_RED,info:$CATPPUCCIN_MAUVE,pointer:$CATPPUCCIN_ROSEWATER \
--color=marker:$CATPPUCCIN_ROSEWATER,fg+:$CATPPUCCIN_TEXT,prompt:$CATPPUCCIN_MAUVE,hl+:$CATPPUCCIN_RED"

# --- Zsh Syntax Highlighting Styles ---
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[command]='fg=#8aadf4'
ZSH_HIGHLIGHT_STYLES[alias]='fg=#8bd5ca'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=#8aadf4'
ZSH_HIGHLIGHT_STYLES[function]='fg=#8aadf4'
ZSH_HIGHLIGHT_STYLES[keyword]='fg=#c6a0f6'
ZSH_HIGHLIGHT_STYLES[string]='fg=#a6da95'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=#f5a97f'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=#f5a97f'
ZSH_HIGHLIGHT_STYLES[path]='fg=#f4dbd6'
ZSH_HIGHLIGHT_STYLES[path_prefix]='fg=#f4dbd6'
ZSH_HIGHLIGHT_STYLES[path_approx]='fg=#f4dbd6'
ZSH_HIGHLIGHT_STYLES[globbing]='fg=#f5bde6'
