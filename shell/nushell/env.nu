# env.nu — Nushell Environment Configuration
# Sources shared paths and environment variables.
# Loaded before config.nu on every Nushell launch.

# Shared source of truth
source ~/dotfiles/shell/shared/paths.nu
source ~/dotfiles/shell/shared/env.nu

# Ensure child processes (like fzf, make, multiplexers) use a POSIX shell
$env.SHELL = "/bin/zsh"
