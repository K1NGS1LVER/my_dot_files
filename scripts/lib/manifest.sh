# Link manifest: the single source of truth for scripts/deploy and scripts/doctor.
# Each LINKS entry is "repo-relative-source|home-relative-target".
# Sourced by bash scripts; do not execute directly.

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

LINKS=(
  # Shells (shell/ is the active layer; top-level zsh/ and nushell/ are legacy)
  "shell/zsh/.zshrc|.zshrc"
  "shell/zsh/.zprofile|.zprofile"
  "bash/.bashrc|.bashrc"
  # Nushell: file-level links only. ~/.config/nushell must stay a REAL directory
  # because nushell writes runtime history (history.sqlite3*) next to its config.
  "shell/nushell/config.nu|.config/nushell/config.nu"
  "shell/nushell/env.nu|.config/nushell/env.nu"

  # Home dotfiles
  "git/.gitconfig|.gitconfig"
  "tmux/.tmux.conf|.tmux.conf"
  "aerospace/.aerospace.toml|.aerospace.toml"
  "surfingkeys/.surfingkeys.js|.surfingkeys.js"
  ".prettierrc|.prettierrc"

  # ~/.config single files
  "starship/.config/starship.toml|.config/starship.toml"

  # ~/.config directories
  "alacritty/.config/alacritty|.config/alacritty"
  "bat/.config/bat|.config/bat"
  "btop/.config/btop|.config/btop"
  "epr/.config/epr|.config/epr"
  "gh/.config/gh|.config/gh"
  "ghostty/.config/ghostty|.config/ghostty"
  "goose/.config/goose|.config/goose"
  "gtk-3.0/.config/gtk-3.0|.config/gtk-3.0"
  "iterm2/.config/iterm2|.config/iterm2"
  "karabiner/.config/karabiner|.config/karabiner"
  "kitty/.config/kitty|.config/kitty"
  "mini/.config/mini|.config/mini"
  "mozilla/.config/mozilla|.config/mozilla"
  "mpv/.config/mpv|.config/mpv"
  "nchat/.config/nchat|.config/nchat"
  "nvim/.config/nvim|.config/nvim"
  "qBittorrent/.config/qBittorrent|.config/qBittorrent"
  "raycast/.config/raycast|.config/raycast"
  "simple-update-notifier/.config/simple-update-notifier|.config/simple-update-notifier"
  "sioyek/.config/sioyek|.config/sioyek"
  "tmux/.config/tmux|.config/tmux"
  "yazi/.config/yazi|.config/yazi"
  "zed/.config/zed|.config/zed"
)

# Home-relative paths that must NOT exist as symlinks anymore.
# deploy backs them up and removes them; doctor flags them if present.
OBSOLETE_LINKS=(
  ".p10k.zsh"       # p10k retired; starship owns the prompt, nothing sources it
  ".config/atuin"   # atuin removed from the stack; repo package no longer exists
)
