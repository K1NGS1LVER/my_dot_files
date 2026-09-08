# Shared aliases — Nushell syntax
# Identical command mappings to aliases.zsh — do not edit one without the other.
# Shell-native commands (reload, ls, du, ps) are intentionally asymmetric.
# Nushell `alias` does not support compound commands, so `ai` uses `def` with `;`-separated commands.

# --- Navigation ---
alias .. = cd ..
alias ... = cd ../..
alias .... = cd ../../..
alias home = cd ~
alias c = clear

# --- Editor ---
alias v = ^nvim
alias vim = ^nvim
alias nvconfig = ^nvim ~/.config/nvim/
alias notes = ^clin --vault ~/notes
alias mini = ^env NVIM_APPNAME=mini nvim

# --- File Listing ---
# Nushell keeps native `ls` (structured data).
alias ll = ls -l
alias la = ls -a

# --- Modern CLI Replacements ---
alias cat = ^bat
alias help = ^tldr

# --- Git ---
alias g = git
alias gs = ^git status
alias gd = ^git diff
alias gc = ^git commit
alias gp = ^git push
alias lg = ^lazygit

# --- Anime & Media ---
alias anim = ^ani-cli

# --- AI ---
def ai [] { cd ~/models; /Users/dan/.local/bin/llama-cli -hf Qwen/Qwen2.5-Coder-7B-Instruct-GGUF:Q4_K_M --flash-attn on --n-gpu-layers 99 --no-mmap --mlock -c 8192 -p "Offline reference assistant. Answer directly, no greetings or filler. If unsure, say so instead of guessing. Be concise; expand only if the question needs depth." }

# --- Display & System ---
alias dark = toggle_dark
alias gray = ^toggle-gray
alias theme-switch = ^switch-theme
alias goodnight = ^sh ~/scripts/goodnight.sh

# --- Dotfiles & Tools ---
alias deploy = ^/Users/dan/dotfiles/scripts/deploy
alias doctor = ^/Users/dan/dotfiles/scripts/doctor
alias dotfiles-deploy = ^/Users/dan/dotfiles/scripts/deploy
alias dotfiles-doctor = ^/Users/dan/dotfiles/scripts/doctor
alias update-brew = ^/Users/dan/dotfiles/scripts/update-brew
alias ts = ^/Users/dan/dotfiles/scripts/tmux-sessionizer
alias tms = ^/Users/dan/dotfiles/scripts/tmux-sessionizer
alias explain = ^/Users/dan/dotfiles/scripts/explain_tree.py

# --- Clipboard ---
alias C = pbcopy
