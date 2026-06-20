# .zprofile — Zsh Login Shell Configuration
# Sources shared paths and environment variables.
# Loaded once per login session (before .zshrc).

# Homebrew shellenv — guarded
[[ -x /opt/homebrew/bin/brew ]] && eval "$(/opt/homebrew/bin/brew shellenv)"

# Shared source of truth
source "$HOME/dotfiles/shell/shared/paths.zsh"
source "$HOME/dotfiles/shell/shared/env.zsh"
