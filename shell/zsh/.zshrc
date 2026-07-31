# .zshrc — Zsh Interactive Shell Configuration
# Lean root config. All paths/env in .zprofile. All logic in modules.

# ─── Shell Options ────────────────────────────
setopt auto_cd
setopt interactive_comments

# ─── History ──────────────────────────────────
mkdir -p "$HOME/.cache/zsh"
HISTFILE="$HOME/.cache/zsh/history"
HISTSIZE=50000
SAVEHIST=50000
setopt SHARE_HISTORY INC_APPEND_HISTORY HIST_IGNORE_DUPS HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS HIST_VERIFY EXTENDED_HISTORY

# ─── Completion System ────────────────────────
# Runs before any third-party installer appends below: several bundled
# completion scripts (e.g. bun's `_bun`) only call `compdef` if `compinit`
# is already loaded, otherwise they bootstrap their own unguarded compinit
# and pay a full compaudit scan. Loading ours first makes theirs a no-op.
export ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
export ZSH_HIGHLIGHT_MAXLENGTH=300
export ZSH_AUTOSUGGEST_USE_ASYNC=1

autoload -Uz compinit bashcompinit
[[ -f "$ZSH_CUSTOM/plugins/zsh-completions/zsh-completions.plugin.zsh" ]] && source "$ZSH_CUSTOM/plugins/zsh-completions/zsh-completions.plugin.zsh"
zcompdump="$HOME/.cache/zsh/zcompdump-$ZSH_VERSION"
# compinit's compaudit security scan costs ~100ms every startup regardless of
# cache validity. Only pay that cost once a day; otherwise skip straight to
# the cached dump. Force a full re-scan any time with `zsh-recompinit`.
if [[ -f "$zcompdump" && -n "$(find "$zcompdump" -mtime -1 2>/dev/null)" ]]; then
  compinit -C -d "$zcompdump"
else
  compinit -d "$zcompdump"
fi
bashcompinit

# ─── Third-party installer appends ───────────
# Installers append raw `export` lines to the end of this file, which breaks
# zoxide's "init must be last" requirement. Keep such appends here, above
# Plugins/Shared Modules, so External Tool Init below stays genuinely last.
export AIRFLOW_HOME="/Users/dan/projects/data_eng_assignments/data_eng_27_june/airflow_home"
export PATH="/Users/dan/.antigravity-ide/antigravity-ide/bin:$PATH"
export PATH="/opt/homebrew/opt/postgresql@17/bin:$PATH"
[ -s "/Users/dan/.bun/_bun" ] && source "/Users/dan/.bun/_bun"

# Plugins — guarded, sourced directly (OMZ framework not used)
[[ -f "$ZSH_CUSTOM/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh" ]] && source "$ZSH_CUSTOM/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
[[ -f "$ZSH_CUSTOM/plugins/fzf-tab/fzf-tab.plugin.zsh" ]] && source "$ZSH_CUSTOM/plugins/fzf-tab/fzf-tab.plugin.zsh"
[[ -f "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]] && source "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# ─── Shared Modules (source of truth) ────────
source "$HOME/dotfiles/shell/shared/aliases.zsh"
source "$HOME/dotfiles/shell/shared/active-theme.zsh"
source "$HOME/dotfiles/shell/shared/browser-sites.zsh"

# ─── Function Modules ────────────────────────
source "$HOME/dotfiles/shell/zsh/functions/browser.zsh"
source "$HOME/dotfiles/shell/zsh/functions/yazi.zsh"
source "$HOME/dotfiles/shell/zsh/functions/system.zsh"
source "$HOME/dotfiles/shell/zsh/functions/multiplexer.zsh"
source "$HOME/dotfiles/shell/zsh/functions/tools.zsh"
source "$HOME/dotfiles/shell/zsh/functions/qol.zsh"
source "$HOME/dotfiles/shell/zsh/functions/docker.zsh"
source "$HOME/dotfiles/shell/zsh/functions/welcome.zsh"

# ─── Zsh-Specific Aliases ────────────────────
alias reload='source ~/.zshrc'
alias zsh-recompinit='rm -f "$HOME/.cache/zsh/zcompdump-$ZSH_VERSION" && exec zsh'
alias zsh-alt='ZDOTDIR=~/projects/bashed zsh'
unalias read 2>/dev/null

# ─── FZF-TAB Configuration ───────────────────
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
zstyle ':fzf-tab:complete:*:*' fzf-preview 'bat --color=always --style=numbers --line-range=:500 $realpath'
zstyle ':fzf-tab:*' switch-group '<' '>'

# ─── Keybindings ──────────────────────────────
bindkey "^W" kill-word
bindkey "^[d" kill-word
bindkey "^U" kill-line
bindkey "^K" kill-line-to-end
bindkey "^?" backward-delete-char
bindkey "^Y" yank
bindkey "^[t" transpose-words
bindkey "^T" transpose-chars

# ─── External Tool Init (all guarded) ────────
command -v zoxide &>/dev/null && eval "$(zoxide init zsh --cmd cd)"
command -v fzf &>/dev/null && source <(fzf --zsh)
[[ "$TERM" != "dumb" ]] && command -v starship &>/dev/null && eval "$(starship init zsh)"
command -v omni &>/dev/null && eval "$(omni hook init zsh)"

# ─── Startup ─────────────────────────────────
welcome-message
