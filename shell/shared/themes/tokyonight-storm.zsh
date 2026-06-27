# Tokyo Night Storm — Zsh color palette + FZF theme + syntax highlighting
# Identical palette to tokyonight-storm.nu — do not edit one without the other.

export BAT_THEME="base16"

# --- Palette Exports ---
export TOKYONIGHT_BG="#24283b"
export TOKYONIGHT_FG="#a9b1d6"
export TOKYONIGHT_COMMENT="#565f89"
export TOKYONIGHT_RED="#f7768e"
export TOKYONIGHT_GREEN="#9ece6a"
export TOKYONIGHT_YELLOW="#e0af68"
export TOKYONIGHT_BLUE="#7aa2f7"
export TOKYONIGHT_PURPLE="#bb9af7"
export TOKYONIGHT_CYAN="#7dcfff"
export TOKYONIGHT_SELECTION="#343b58"

# --- FZF Theme (Tokyo Night Storm) ---
export FZF_DEFAULT_OPTS=" \
--color=bg+:$TOKYONIGHT_SELECTION,bg:$TOKYONIGHT_BG,spinner:$TOKYONIGHT_CYAN,hl:$TOKYONIGHT_RED \
--color=fg:$TOKYONIGHT_FG,header:$TOKYONIGHT_RED,info:$TOKYONIGHT_PURPLE,pointer:$TOKYONIGHT_CYAN \
--color=marker:$TOKYONIGHT_CYAN,fg+:$TOKYONIGHT_FG,prompt:$TOKYONIGHT_PURPLE,hl+:$TOKYONIGHT_RED"

# --- Zsh Syntax Highlighting Styles ---
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[command]='fg=#7aa2f7'
ZSH_HIGHLIGHT_STYLES[alias]='fg=#9ece6a'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=#7aa2f7'
ZSH_HIGHLIGHT_STYLES[function]='fg=#9ece6a'
ZSH_HIGHLIGHT_STYLES[keyword]='fg=#bb9af7'
ZSH_HIGHLIGHT_STYLES[string]='fg=#e0af68'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=#ff9e64'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=#ff9e64'
ZSH_HIGHLIGHT_STYLES[path]='fg=#a9b1d6'
ZSH_HIGHLIGHT_STYLES[path_prefix]='fg=#a9b1d6'
ZSH_HIGHLIGHT_STYLES[path_approx]='fg=#a9b1d6'
ZSH_HIGHLIGHT_STYLES[globbing]='fg=#bb9af7'
