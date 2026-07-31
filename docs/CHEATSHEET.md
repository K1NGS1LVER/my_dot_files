# Cheatsheet

Commands work in both Zsh and Nushell unless noted otherwise.

## Shell

| Command | Action |
|---|---|
| `reload` | Reload shell config (Zsh: `source ~/.zshrc`, Nu: `exec nu`) |
| `nvconfig` | Open Neovim config |
| `nvguide` | Open setup guide in Neovim |
| `nvcheat` | Open this cheatsheet in Neovim |
| `up` | Update all package managers (brew, npm, pipx, gem, bob, …) |
| `cleanup` | Purge brew cache, Docker pruning, npm cache |
| `nu-regen-cache` | Regenerate Nushell tool init caches (run after upgrading carapace/fzf/starship/zoxide) |

## Navigation

| Command | Action |
|---|---|
| `y` | Open Yazi; sync shell cwd on exit |
| `yazi` | Open Yazi directly |
| `ntmux` | Attach to or create the default Zellij session (`dan`) |
| `ttmux` / `t` | Attach to or create the default abduco session (`main`) |
| `tkill <name>` / `tk` | Kill an abduco session matching `<name>` |
| `home` | `cd ~` |
| `..` / `...` | Go up one / two directories |
| `vf` | Fuzzy find a file and open in `$EDITOR` |
| `Ctrl+F` | Fuzzy find any file under `~` and insert path at cursor |
| `Ctrl+T` | Fuzzy find files in current directory (fzf default) |

## Browser Shortcuts

```
brave <site> [query]    # Open or search a site in Brave
fox <site> [query]      # Open or search a site in Firefox
wolf <site> [query]     # Open or search a site in LibreWolf
```

Site keys: `yt`, `gh`, `g`, `rd`, `x`, `li`, `hi`, `mt`, `kb`, `gf`, `cl`, `cu`, `net`

## File Operations

| Command | Action |
|---|---|
| `pdf <file>` | Open PDF in Sioyek (new window) |
| `open <file>` | Dispatch by extension: code → nvim, pdf → sioyek, video → IINA |
| `cap <cmd>` | Save stdout+stderr to a timestamped file |
| `rec` | Record full terminal session with `script` (Zsh only) |
| `bak <file>` | Backup a file with a timestamp suffix |
| `extract <file>` | Unpack zip/tar/7z/rar by extension |
| `C` | Pipe output to clipboard (`echo hello C`) |

## System Info & Utilities

| Command | Action |
|---|---|
| `fetch` | fastfetch system summary |
| `sysinfo` | Nushell-native system summary |
| `duf` | Disk usage (duf or df -h fallback) |
| `big-files [n]` | Top N largest files in cwd |
| `ports` | List listening TCP ports |
| `myip` | Public + local IP address |
| `isup <url>` | Check if a site is reachable |
| `serve [port]` | Serve cwd over HTTP (default: 8080) |
| `cheat <query>` | Fetch cheat.sh snippet |
| `sshf` | Fuzzy-pick a host from `~/.ssh/config` and connect |

## Docker

| Command | Action |
|---|---|
| `dps` | Running containers (name/status/ports) |
| `dimg` | Local images (repo/tag/size) |
| `dstop` | Stop all running containers |
| `dclean` | Prune stopped containers + unused images |
| `dsh` | Fuzzy-pick a running container and exec into it |

## Notes & Tools

| Command | Action |
|---|---|
| `note add <text>` | Append a timestamped note to `~/.notes.md` |
| `note show` | Print all notes |
| `note edit` | Open notes in nvim |
| `todo` | Fuzzy-select a Todoist task to close |
| `timer <seconds>` | Countdown timer with macOS notification |
| `proj <name> [template]` | Scaffold a new project (basic/node/python) |

## Themes

| Command | Action |
|---|---|
| `theme-switch` | Fuzzy-pick a theme (Ghostty, Kitty, Alacritty, Zsh, Nushell, Neovim, Yazi, tmux) |
| `theme-switch <name>` | Switch directly, e.g. `theme-switch gruvbox-dark` |
| `theme-switch none` | Plain terminal, no theme/accent colors (Neovim keeps its last real theme - NvChad has no equivalent "no theme" mode) |

Already-open Zsh/Nushell panes need `reload` (or a fresh shell) to pick up a new palette; Ghostty/Kitty/tmux update live.

## Local LLM

| Command | Action |
|---|---|
| `ai` | Chat with `Qwen2.5-Coder-7B-Instruct` (Q4_K_M) via llama-cli (interactive) |

Runs `llama-cli` with the Qwen2.5-Coder GGUF quantized model from `~/models`, 99 GPU layers, 8192 context length, and a system prompt. Requires `llama-cli` binary in PATH and the model GGUF file present at `~/models`.

### llama-server
For agent harnesses that need an HTTP API endpoint, `llama-server` runs as a LaunchAgent (`com.dan.llama-server`) on port 8080. Manage it with:

```
launchctl start com.dan.llama-server    # start
launchctl stop com.dan.llama-server      # stop
launchctl list | grep llama-server        # check status
```

The server exposes an OpenAI-compatible API at `http://127.0.0.1:8080/v1`. `OPENAI_BASE_URL` is set in the shell env to point to this endpoint, so OpenCode and Pi Code will route to llama-server automatically. Pi Code config: `~/.pi/agent/models.json` (provider `llama-server`). The `ai` alias uses `llama-cli` for interactive chat; `llama-server` serves the same model for API clients. Both use the same flags: 99 GPU layers, 8192 context, no mmap, mlock.

## Git

| Command | Action |
|---|---|
| `lg` | LazyGit |
| `g` | git |
| `gs` | git status |
| `gd` | git diff |
| `gc` | git commit |
| `gp` | git push |

## Kotlin

| Command | Action |
|---|---|
| `k` | kotlin REPL |
| `kc` | kotlinc compiler |
| `krun <file.kt>` | Compile, run, and clean up a Kotlin file |

## Ghostty

| Binding | Action |
|---|---|
| `cmd+shift+r` | Reload config |
| `cmd+shift+o` | Toggle background transparency |

## Neovim

| Binding | Action |
|---|---|
| `<leader>gg` | LazyGit |
| `<leader>xx` | Diagnostics list |
| `<leader>z` | Zen mode |
| `<leader>tt` | Toggle transparency |
| `<leader>sl` | Restore last session (cwd-scoped) |
| `<leader>sd` | Don't save session on exit |
| `<leader>db/dc/du` | DAP basics |

## AeroSpace

| Binding | Action |
|---|---|
| `alt-1..9` | Switch workspace |
| `alt-shift-1..9` | Move focused window to workspace |
| `alt-tab` | Jump to previous workspace |
| `alt-space` | Toggle floating/tiling |

## Rules

- The repo is the source of truth. Edit repo targets, not symlink destinations.
- Runtime state stays out of git.
- After editing shared modules (`shell/shared/`), update both the `.zsh` and `.nu` file.
