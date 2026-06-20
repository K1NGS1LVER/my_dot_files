# Shared environment variables — Zsh syntax
# Identical values to env.nu — do not edit one without the other.

export EDITOR="nvim"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export BAT_THEME="Catppuccin Macchiato"
export LYNX_CFG="$HOME/.lynx.cfg"
export LYNX_LSS="$HOME/.lynx.lss"
export PNPM_HOME="$HOME/Library/pnpm"
export YAZI_TRT="5000"
export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense'

# JAVA_HOME — guarded: skip silently if java is not installed
if command -v /usr/libexec/java_home &>/dev/null; then
    export JAVA_HOME=$(/usr/libexec/java_home)
fi
