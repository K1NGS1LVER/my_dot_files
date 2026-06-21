# config.nu — Nushell Interactive Configuration
# Lean root config. All paths/env in env.nu. All logic in modules.

# ─── Catppuccin (must be const — parse-time for color_config) ───
source ~/dotfiles/shell/shared/catppuccin.nu

# ─── Prompt (suppressed — Starship handles it) ──────────────────
$env.PROMPT_INDICATOR = ""
$env.PROMPT_INDICATOR_VI_INSERT = ""
$env.PROMPT_INDICATOR_VI_NORMAL = ""
$env.PROMPT_MULTILINE_INDICATOR = ""

# ─── Shared Aliases ─────────────────────────────────────────────
source ~/dotfiles/shell/shared/aliases.nu

# ─── Function Modules ───────────────────────────────────────────
source ~/dotfiles/shell/nushell/modules/browser.nu
source ~/dotfiles/shell/nushell/modules/yazi.nu
source ~/dotfiles/shell/nushell/modules/system.nu
source ~/dotfiles/shell/nushell/modules/multiplexer.nu
source ~/dotfiles/shell/nushell/modules/tools.nu
source ~/dotfiles/shell/nushell/modules/docker.nu
source ~/dotfiles/shell/nushell/modules/qol.nu
source ~/dotfiles/shell/nushell/modules/welcome.nu

# ─── Nushell-Specific Aliases ───────────────────────────────────
alias reload = exec nu
alias src = view-source

# ─── Configuration ──────────────────────────────────────────────
$env.config = {
    show_banner: false
    edit_mode: vi
    highlight_resolved_externals: true

    ls: {
        use_ls_colors: true
        clickable_links: true
    }

    rm: {
        always_trash: true
    }

    table: {
        mode: rounded
        index_mode: always
        show_empty: true
        padding: { left: 1, right: 1 }
        trim: {
            methodology: wrapping
            wrapping_try_keep_words: true
            truncating_suffix: "..."
        }
        header_on_separator: false
    }

    error_style: "fancy"

    color_config: {
        separator:                  $catppuccin.overlay0
        leading_trailing_space_bg:  { attr: n }
        header:                     { fg: $catppuccin.blue attr: b }
        empty:                      $catppuccin.blue
        bool:                       $catppuccin.peach
        int:                        $catppuccin.peach
        filesize:                   $catppuccin.sapphire
        duration:                   $catppuccin.subtext1
        date:                       $catppuccin.teal
        range:                      $catppuccin.peach
        float:                      $catppuccin.peach
        string:                     $catppuccin.green
        nothing:                    $catppuccin.peach
        binary:                     $catppuccin.peach
        cell-path:                  $catppuccin.text
        row_index:                  { fg: $catppuccin.mauve attr: b }
        record:                     $catppuccin.text
        list:                       $catppuccin.text
        block:                      $catppuccin.text
        hints:                      $catppuccin.overlay1
        search_results:             { fg: $catppuccin.base bg: $catppuccin.yellow }

        shape_and:                  $catppuccin.mauve
        shape_binary:               $catppuccin.mauve
        shape_block:                $catppuccin.blue
        shape_bool:                 $catppuccin.teal
        shape_custom:               $catppuccin.green
        shape_datetime:             $catppuccin.teal
        shape_directory:            $catppuccin.blue
        shape_external:             $catppuccin.red
        shape_external_resolved:    $catppuccin.green
        shape_externalarg:          $catppuccin.green
        shape_filepath:             $catppuccin.teal
        shape_flag:                 $catppuccin.sky
        shape_float:                $catppuccin.mauve
        shape_garbage:              { fg: $catppuccin.red attr: b }
        shape_globpattern:          $catppuccin.teal
        shape_int:                  $catppuccin.mauve
        shape_internalcall:         $catppuccin.green
        shape_keyword:              $catppuccin.mauve
        shape_list:                 $catppuccin.sky
        shape_literal:              $catppuccin.blue
        shape_match_pattern:        $catppuccin.green
        shape_matching_brackets:    { attr: u }
        shape_nothing:              $catppuccin.teal
        shape_operator:             $catppuccin.yellow
        shape_or:                   $catppuccin.mauve
        shape_pipe:                 $catppuccin.mauve
        shape_range:                $catppuccin.yellow
        shape_record:               $catppuccin.sky
        shape_redirection:          $catppuccin.mauve
        shape_signature:            $catppuccin.green
        shape_string:               $catppuccin.green
        shape_string_interpolation: $catppuccin.teal
        shape_table:                $catppuccin.blue
        shape_variable:             $catppuccin.flamingo
        shape_vardecl:              $catppuccin.flamingo
    }

    hooks: {
        pre_execution: [
            {||
                if ("ZELLIJ" in $env) {
                    let cmd = (commandline | default "" | str trim | str substring 0..15)
                    if ($cmd | is-not-empty) {
                        ^zellij action rename-tab $cmd out+err> /dev/null
                    }
                }
            }
        ]
        pre_prompt: [
            {||
                if ("ZELLIJ" in $env) {
                    let tab_name = ($env.PWD | path basename)
                    ^zellij action rename-tab $tab_name out+err> /dev/null
                }
            }
        ]
    }

    completions: {
        case_sensitive: false
        quick: true
        partial: true
        algorithm: "prefix"
        external: {
            enable: true
            max_results: 100
        }
        use_ls_colors: true
    }

    buffer_editor: "nvim"

    cursor_shape: {
        vi_insert: line
        vi_normal: block
        emacs: line
    }

    history: {
        file_format: "sqlite"
        max_size: 100_000
        sync_on_enter: true
        isolation: false
    }
}

# ─── External Tool Init ────────────────────────────────────────
# NOTE: Nushell's `source` is a parse-time directive — it CANNOT be placed
# inside `if` blocks. Cache files must always exist. If a tool is uninstalled,
# its empty/stale cache file is harmless (no-op). Run `nu-regen-cache` to
# regenerate after installing/upgrading tools.

def nu-regen-cache [] {
    mkdir ~/.cache/carapace ~/.cache/fzf ~/.cache/starship ~/.cache/zoxide
    if not (which carapace | is-empty) { ^carapace _carapace nushell | save --force ~/.cache/carapace/init.nu }
    if not (which fzf | is-empty) { ^fzf --nushell | save --force ~/.cache/fzf/init.nu }
    if not (which starship | is-empty) { ^starship init nu | save --force ~/.cache/starship/init.nu }
    if not (which zoxide | is-empty) { ^zoxide init nushell --cmd cd | save --force ~/.cache/zoxide/init.nu }
    print "✅ Nushell cache files regenerated. Restart shell to apply."
}

source ~/.cache/carapace/init.nu
source ~/.cache/fzf/init.nu
source ~/.cache/starship/init.nu
source ~/.cache/zoxide/init.nu

# ─── Universal Home Directory Fuzzy Finder (Ctrl+F) ────────────
let fzf_universal_binding = {
    name: fzf_universal_files
    modifier: control
    keycode: char_f
    mode: [emacs, vi_normal, vi_insert]
    event: [
        {
            send: executehostcommand
            cmd: "
                let cmd = 'fd --type f --hidden --follow --exclude .git --exclude Library --exclude .cache --exclude node_modules --exclude .cargo --exclude .npm . ~'
                let fzf_opts = '--reverse --preview \"bat --style=numbers --color=always --line-range :500 {} 2>/dev/null || cat {} 2>/dev/null\"'
                let sh_cmd = [$cmd '| fzf' $fzf_opts] | str join ' '
                let result = (with-env { FZF_DEFAULT_OPTS: '', FZF_DEFAULT_OPTS_FILE: '', SHELL: '/bin/sh' } { ^sh -c $sh_cmd } | str trim)
                if ($result | is-not-empty) {
                    commandline edit --append $result
                    commandline set-cursor --end
                }
            "
        }
    ]
}

$env.config.keybindings = ($env.config.keybindings | append $fzf_universal_binding)

# ─── Startup ───────────────────────────────────────────────────
welcome-message
