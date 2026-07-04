# env.nu — Nushell Environment Configuration
# Sources shared paths and environment variables.
# Loaded before config.nu on every Nushell launch.

# Shared source of truth
source ~/dotfiles/shell/shared/paths.nu
source ~/dotfiles/shell/shared/env.nu

# Ensure child processes (like fzf, make, multiplexers) use a POSIX shell
$env.SHELL = "/bin/zsh"

# ─── Self-healing cache regeneration ───────────────────────────
# config.nu sources ~/.cache/{carapace,fzf,starship,zoxide}/init.nu at parse
# time, which cannot be wrapped in `if`. Regenerate any that are missing here,
# in env.nu, which always runs first — so a wiped ~/.cache cannot brick
# Nushell startup. This is a plain script context, so `if` is safe to use.
mkdir ~/.cache/carapace ~/.cache/fzf ~/.cache/starship ~/.cache/zoxide
if not ("~/.cache/carapace/init.nu" | path expand | path exists) and not (which carapace | is-empty) {
    ^carapace _carapace nushell | save --force ~/.cache/carapace/init.nu
}
if not ("~/.cache/fzf/init.nu" | path expand | path exists) and not (which fzf | is-empty) {
    ^fzf --nushell | save --force ~/.cache/fzf/init.nu
}
if not ("~/.cache/starship/init.nu" | path expand | path exists) and not (which starship | is-empty) {
    ^starship init nu | save --force ~/.cache/starship/init.nu
}
if not ("~/.cache/zoxide/init.nu" | path expand | path exists) and not (which zoxide | is-empty) {
    ^zoxide init nushell --cmd cd | save --force ~/.cache/zoxide/init.nu
}
# Any cache file still missing here (tool not installed) gets an empty
# placeholder so config.nu's unconditional `source` does not error.
for cache in [carapace fzf starship zoxide] {
    let f = ($"~/.cache/($cache)/init.nu" | path expand)
    if not ($f | path exists) { "" | save --force $f }
}
