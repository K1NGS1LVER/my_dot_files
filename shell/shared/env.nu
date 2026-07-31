# Shared environment variables — Nushell syntax
# Identical values to env.zsh — do not edit one without the other.

$env.EDITOR = "nvim"
$env.MANPAGER = "sh -c 'col -bx | bat -l man -p'"
$env.LYNX_CFG = ($env.HOME | path join ".lynx.cfg")
$env.LYNX_LSS = ($env.HOME | path join ".lynx.lss")
$env.PNPM_HOME = ($env.HOME | path join "Library" "pnpm")
$env.YAZI_TRT = "5000"
$env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense'
$env.OPENAI_BASE_URL = "http://127.0.0.1:8080/v1"

# JAVA_HOME — guarded: skip silently if java is not installed
if ("/usr/libexec/java_home" | path exists) {
    $env.JAVA_HOME = (^/usr/libexec/java_home | str trim)
}
