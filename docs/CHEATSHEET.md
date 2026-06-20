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
| `home` | `cd ~` |
| `..` / `...` | Go up one / two directories |
| `vf` | Fuzzy find a file and open in `$EDITOR` |
| `Ctrl+F` | Fuzzy find any file under `~` and insert path at cursor |
| `Ctrl+T` | Fuzzy find files in current directory (fzf default) |

## Browser Shortcuts

```
brave <site> [query]    # Open or search a site in Brave
fox <site> [query]      # Open or search a site in Firefox
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

## Notes & Tools

| Command | Action |
|---|---|
| `note add <text>` | Append a timestamped note to `~/.notes.md` |
| `note show` | Print all notes |
| `note edit` | Open notes in nvim |
| `todo` | Fuzzy-select a Todoist task to close |
| `timer <seconds>` | Countdown timer with macOS notification |
| `proj <name> [template]` | Scaffold a new project (basic/node/python) |

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

## Neovim

| Binding | Action |
|---|---|
| `<leader>gg` | LazyGit |
| `<leader>xx` | Diagnostics list |
| `<leader>z` | Zen mode |
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
