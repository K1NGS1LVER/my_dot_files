# Shared aliases — Nushell syntax
# Identical command mappings to aliases.zsh — do not edit one without the other.
# Shell-native commands (reload, ls, du, ps) are intentionally asymmetric.
# Nushell `alias` does not support compound commands, so `ai` uses `def` with `;`-separated commands.

# --- Editor ---
alias vim = ^nvim
alias vi = ^nvim
alias v = ^nvim
alias nv = ^nvim
alias og = ^/usr/bin/vim
alias nvconfig = ^nvim ~/.config/nvim/
alias nvguide = ^nvim ~/dotfiles/docs/SETUP_GUIDE.md
alias nvcheat = ^nvim ~/dotfiles/docs/CHEATSHEET.md
alias notes = ^clin --vault ~/notes

# --- Navigation ---
alias home = cd ~
alias c = clear
alias .. = cd ..
alias ... = cd ../..
alias .... = cd ../../..
alias ..... = cd ../../../../..

# --- File Listing ---
# Nushell keeps native `ls` (structured data). Eza available as `els`.
alias ll = ls -l
alias la = ls -a
alias lla = ls -la
alias els = ^eza --icons

# --- Modern CLI Replacements ---
alias cat = ^bat
alias help = ^tldr
alias sed = ^sd
alias les = ^less -R
# du and ps are Nushell built-ins — not aliased. Use ^dust / ^procs explicitly.

# --- Git ---
alias g = git
alias gs = ^git status
alias gd = ^git diff
alias gc = ^git commit
alias gp = ^git push
alias lg = ^lazygit

# --- Kotlin ---
alias k = ^kotlin
alias kc = ^kotlinc

# --- Media & Apps ---
alias play = ^mpv
alias watch = ^open -a IINA
alias book = ^open -a Books
alias meow = echo
alias bark = ls

# --- Anime ---
alias anim = ^ani-cli
alias anim-c = ^ani-cli -c
alias anim-res = ^ani-cli -q 1080
alias anim-dl = ^ani-cli -d

# --- AI ---
def ai [] { cd ~/models; /Users/dan/.local/bin/llama-cli -hf Qwen/Qwen3-8B-GGUF:Q4_K_M --flash-attn on --n-gpu-layers 99 --no-mmap --mlock -c 8192 -p "You are a helpful assistant." }

# --- Display & System ---
alias dark = toggle_dark
alias gray = ^toggle-gray
alias sepia = ^shortcuts run "Sepia Mode"
alias theme-switch = ^/Users/dan/dotfiles/scripts/switch-theme
alias goodnight = ^sh ~/scripts/goodnight.sh
alias packettracer = ^open "/Applications/Cisco Packet Tracer 9.0.0/Cisco Packet Tracer 9.0.app"

# --- tmux ---
alias tmux-sessionizer = ^/Users/dan/dotfiles/scripts/tmux-sessionizer

# --- Dotfiles maintenance ---
alias dotfiles-deploy = ^/Users/dan/dotfiles/scripts/deploy
alias dotfiles-doctor = ^/Users/dan/dotfiles/scripts/doctor
alias update-nvim-plugins = ^/Users/dan/dotfiles/scripts/update-nvim-plugins
alias update-notebook-env = ^/Users/dan/dotfiles/scripts/update-notebook-env
alias update-brew = ^/Users/dan/dotfiles/scripts/update-brew

# --- Clipboard ---
alias C = pbcopy
