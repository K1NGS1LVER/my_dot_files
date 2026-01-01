# NvChad Cheatsheet

## 🎯 Most Used Commands

### File Operations

```
Space ff    Find files
Space fw    Search text in project
Ctrl+n      Toggle file tree
Space fb    List open buffers :w          Save file
:q          Quit
:wq         Save and quit
```

### Navigation

```
hjkl        Move cursor (left/down/up/right)
w           Next word
b           Previous word
gg          Go to top
G           Go to bottom
Ctrl+d      Half page down
Ctrl+u      Half page up
gd          Go to definition (LSP)
Ctrl+o      Jump back
Ctrl+i      Jump forward
```

### Editing

```
i           Insert before cursor
a           Insert after cursor
o           New line below
O           New line above dd          Delete line
yy          Copy line
p           Paste
u           Undo
Ctrl+r      Redo
gcc         Toggle line comment
```

### Terminal

```
Ctrl+\      Toggle terminal
Space th    Horizontal terminal
Space tv    Vertical terminal
exit        Close terminal
```

### Git

```
Space gg    Open LazyGit
```

### Search

```
/pattern    Search forward
?pattern    Search backward
n           Next result
N           Previous result
*           Search word under cursor
Esc         Clear highlight
```

### LSP

```
K           Hover docs
gd          Go to definition
gr          Find references
Space ca    Code action
Space rn    Rename
Space lf    Format code
[d          Previous diagnostic
]d          Next diagnostic
```

### Visual Mode

```
v           Visual mode
V           Visual line mode
Ctrl+v      Visual block mode
>           Indent right
<           Indent left
```

### Windows

```
:sp         Horizontal split
:vsp        Vertical split
Ctrl+w h/j/k/l    Navigate windows
Ctrl+w q    Close window
```

## 💡 Pro Tips

1. **Learn hjkl first** - Disable arrow keys if needed
2. **Use relative line numbers** - Jump with `10j` or `5k`
3. **Master visual mode** - Select, then operate
4. **. (dot) repeats** - Your best friend
5. **Search with /** - Then `n` to navigate
6. **Use marks** - `ma` to set, `'a` to jump
7. **Macros** - `qq` to record to q, `@q` to replay

## 🔧 Quick Fixes

```
:Lazy sync              Update all plugins
:Mason                  Install LSP servers
:TSUpdate               Update treesitter
:checkhealth            Check for issues
:e!                     Reload file
:source %               Reload config
```

## 🎨 Common Patterns

### Find and Replace

```
:%s/old/new/g           Replace in file
:%s/old/new/gc          Replace with confirm
:'<,'>s/old/new/g       Replace in selection
```

### Multiple Cursors Effect

```
1. Search: /pattern
2. Visual block: Ctrl+v
3. Select lines: j or k
4. Insert: I or A
5. Type, then Esc
```

### Quick File Navigation

```
Space ff                Fuzzy find files
Space fw                Find word
gf                      Go to file under cursor
:e path/to/file         Edit file
```

---

**Press Space in Neovim to see all available commands via Which-Key!**
