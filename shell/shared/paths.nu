# Canonical PATH list — Nushell syntax
# Order: highest priority first. Identical to paths.zsh.
# Every entry is paired across both files — do not edit one without the other.

$env.PATH = (
    $env.PATH
    | split row (char esep)
    | prepend [
        ($env.HOME | path join "dotfiles" "scripts")               # 1.  Custom scripts
        "/opt/homebrew/bin"                                         # 2.  Homebrew primary
        "/opt/homebrew/sbin"                                        # 3.  Homebrew system
        "/usr/local/bin"                                            # 4.  System local
        "/usr/bin"                                                  # 5.  System
        "/bin"                                                      # 6.  Core
        "/usr/sbin"                                                 # 7.  System admin
        "/sbin"                                                     # 8.  Core admin
    ]
    | append [
        ($env.HOME | path join ".local" "bin")                      # 9.  Pipx, user binaries
        ($env.HOME | path join ".cargo" "bin")                      # 10. Rust toolchain
        ($env.HOME | path join ".local" "share" "nvim" "mason" "bin")  # 11. Mason LSPs
        ($env.HOME | path join ".local" "share" "bob" "nvim-bin")   # 12. Bob Neovim manager
        "/opt/homebrew/opt/openjdk/bin"                             # 13. Java (OpenJDK)
        "/Applications/Android Studio.app/Contents/MacOS"           # 14. Android Studio
        ($env.HOME | path join "Library" "pnpm")                    # 15. pnpm global binaries
    ]
    | uniq
)
