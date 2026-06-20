# Shared aliases — Nushell syntax
# Identical command mappings to aliases.zsh — do not edit one without the other.
# Shell-native commands (reload, ls, du, ps) are intentionally asymmetric.

# --- Editor ---
alias vim = ^nvim
alias vi = ^nvim
alias v = ^nvim
alias nv = ^nvim
alias og = ^/usr/bin/vim
alias nvconfig = ^nvim ~/.config/nvim/
alias nvguide = ^nvim ~/dotfiles/docs/SETUP_GUIDE.md
alias nvcheat = ^nvim ~/dotfiles/docs/CHEATSHEET.md

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
alias ai = ^ollama run qwen2.5-coder:7b

# --- Display & System ---
alias dark = toggle_dark
alias gray = ^shortcuts run "Toggle Grayscale"
alias sepia = ^shortcuts run "Sepia Mode"
alias goodnight = ^sh ~/scripts/goodnight.sh
alias packettracer = ^open "/Applications/Cisco Packet Tracer 9.0.0/Cisco Packet Tracer 9.0.app"

# --- Clipboard ---
alias C = pbcopy
