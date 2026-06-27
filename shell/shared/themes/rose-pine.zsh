# Rose Pine — Zsh color palette + FZF theme + syntax highlighting
# Identical palette to rose-pine.nu — do not edit one without the other.

export BAT_THEME="base16"

# --- Palette Exports ---
export ROSEPINE_BG="#191724"
export ROSEPINE_FG="#e0def4"
export ROSEPINE_COMMENT="#908caa"
export ROSEPINE_RED="#eb6f92"
export ROSEPINE_GREEN="#31748f"
export ROSEPINE_YELLOW="#f6c177"
export ROSEPINE_BLUE="#9ccfd8"
export ROSEPINE_PURPLE="#c4a7e7"
export ROSEPINE_CYAN="#ebbcba"
export ROSEPINE_SELECTION="#403d52"

# --- FZF Theme (Rose Pine) ---
export FZF_DEFAULT_OPTS=" \
--color=bg+:$ROSEPINE_SELECTION,bg:$ROSEPINE_BG,spinner:$ROSEPINE_CYAN,hl:$ROSEPINE_RED \
--color=fg:$ROSEPINE_FG,header:$ROSEPINE_RED,info:$ROSEPINE_PURPLE,pointer:$ROSEPINE_CYAN \
--color=marker:$ROSEPINE_CYAN,fg+:$ROSEPINE_FG,prompt:$ROSEPINE_PURPLE,hl+:$ROSEPINE_RED"

# --- Zsh Syntax Highlighting Styles ---
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[command]='fg=#9ccfd8'
ZSH_HIGHLIGHT_STYLES[alias]='fg=#31748f'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=#9ccfd8'
ZSH_HIGHLIGHT_STYLES[function]='fg=#31748f'
ZSH_HIGHLIGHT_STYLES[keyword]='fg=#c4a7e7'
ZSH_HIGHLIGHT_STYLES[string]='fg=#f6c177'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=#ebbcba'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=#ebbcba'
ZSH_HIGHLIGHT_STYLES[path]='fg=#e0def4'
ZSH_HIGHLIGHT_STYLES[path_prefix]='fg=#e0def4'
ZSH_HIGHLIGHT_STYLES[path_approx]='fg=#e0def4'
ZSH_HIGHLIGHT_STYLES[globbing]='fg=#c4a7e7'
