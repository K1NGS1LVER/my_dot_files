# Gruvbox Dark — Zsh color palette + FZF theme + syntax highlighting
# Identical palette to gruvbox-dark.nu — do not edit one without the other.

export BAT_THEME="gruvbox-dark"

# --- Palette Exports ---
export GRUVBOX_BG="#282828"
export GRUVBOX_FG="#ebdbb2"
export GRUVBOX_COMMENT="#928374"
export GRUVBOX_RED="#fb4934"
export GRUVBOX_GREEN="#b8bb26"
export GRUVBOX_YELLOW="#fabd2f"
export GRUVBOX_BLUE="#83a598"
export GRUVBOX_PURPLE="#d3869b"
export GRUVBOX_CYAN="#8ec07c"
export GRUVBOX_SELECTION="#504945"

# --- FZF Theme (Gruvbox Dark) ---
export FZF_DEFAULT_OPTS=" \
--color=bg+:$GRUVBOX_SELECTION,bg:$GRUVBOX_BG,spinner:$GRUVBOX_CYAN,hl:$GRUVBOX_RED \
--color=fg:$GRUVBOX_FG,header:$GRUVBOX_RED,info:$GRUVBOX_PURPLE,pointer:$GRUVBOX_CYAN \
--color=marker:$GRUVBOX_CYAN,fg+:$GRUVBOX_FG,prompt:$GRUVBOX_PURPLE,hl+:$GRUVBOX_RED"

# --- Zsh Syntax Highlighting Styles ---
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[command]='fg=#83a598'
ZSH_HIGHLIGHT_STYLES[alias]='fg=#b8bb26'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=#83a598'
ZSH_HIGHLIGHT_STYLES[function]='fg=#b8bb26'
ZSH_HIGHLIGHT_STYLES[keyword]='fg=#d3869b'
ZSH_HIGHLIGHT_STYLES[string]='fg=#fabd2f'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=#fe8019'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=#fe8019'
ZSH_HIGHLIGHT_STYLES[path]='fg=#ebdbb2'
ZSH_HIGHLIGHT_STYLES[path_prefix]='fg=#ebdbb2'
ZSH_HIGHLIGHT_STYLES[path_approx]='fg=#ebdbb2'
ZSH_HIGHLIGHT_STYLES[globbing]='fg=#d3869b'
