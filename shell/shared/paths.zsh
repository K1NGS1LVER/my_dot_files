# Canonical PATH array — Zsh syntax
# Order: highest priority first. Identical to paths.nu.
# Every entry is paired across both files — do not edit one without the other.

typeset -U path PATH

path=(
    $HOME/dotfiles/scripts               # 1.  Custom scripts
    /opt/homebrew/bin                     # 2.  Homebrew primary
    /opt/homebrew/sbin                    # 3.  Homebrew system
    /usr/local/bin                        # 4.  System local
    /usr/bin                              # 5.  System
    /bin                                  # 6.  Core
    /usr/sbin                             # 7.  System admin
    /sbin                                 # 8.  Core admin
    $HOME/.local/bin                      # 9.  Pipx, user binaries
    $HOME/.cargo/bin                      # 10. Rust toolchain
    $HOME/.local/share/nvim/mason/bin     # 11. Mason LSPs
    $HOME/.local/share/bob/nvim-bin       # 12. Bob Neovim manager
    /opt/homebrew/opt/openjdk/bin         # 13. Java (OpenJDK)
    "/Applications/Android Studio.app/Contents/MacOS"  # 14. Android Studio
    $HOME/Library/pnpm                    # 15. pnpm global binaries
    $path
)
