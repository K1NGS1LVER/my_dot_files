# Monokai Pro — Zsh color palette + FZF theme + syntax highlighting
# Identical palette to monokai-pro.nu — do not edit one without the other.

export BAT_THEME="Monokai Extended"

# --- Palette Exports ---
export MONOKAI_BG="#2d2a2e"
export MONOKAI_FG="#fcfcfa"
export MONOKAI_COMMENT="#727072"
export MONOKAI_RED="#ff6188"
export MONOKAI_GREEN="#a9dc76"
export MONOKAI_YELLOW="#ffd866"
export MONOKAI_ORANGE="#fc9867"
export MONOKAI_PURPLE="#ab9df2"
export MONOKAI_CYAN="#78dce8"
export MONOKAI_SELECTION="#403e41"
export MONOKAI_OVERLAY="#5b595c"

# --- FZF Theme (Monokai Pro) ---
export FZF_DEFAULT_OPTS=" \
--color=bg+:$MONOKAI_SELECTION,bg:$MONOKAI_BG,spinner:$MONOKAI_ORANGE,hl:$MONOKAI_RED \
--color=fg:$MONOKAI_FG,header:$MONOKAI_RED,info:$MONOKAI_PURPLE,pointer:$MONOKAI_ORANGE \
--color=marker:$MONOKAI_ORANGE,fg+:$MONOKAI_FG,prompt:$MONOKAI_PURPLE,hl+:$MONOKAI_RED"

# --- Zsh Syntax Highlighting Styles ---
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[command]='fg=#78dce8'
ZSH_HIGHLIGHT_STYLES[alias]='fg=#a9dc76'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=#78dce8'
ZSH_HIGHLIGHT_STYLES[function]='fg=#a9dc76'
ZSH_HIGHLIGHT_STYLES[keyword]='fg=#ff6188'
ZSH_HIGHLIGHT_STYLES[string]='fg=#ffd866'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=#fc9867'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=#fc9867'
ZSH_HIGHLIGHT_STYLES[path]='fg=#fcfcfa'
ZSH_HIGHLIGHT_STYLES[path_prefix]='fg=#fcfcfa'
ZSH_HIGHLIGHT_STYLES[path_approx]='fg=#fcfcfa'
ZSH_HIGHLIGHT_STYLES[globbing]='fg=#ab9df2'
