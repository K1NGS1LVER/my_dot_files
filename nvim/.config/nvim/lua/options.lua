require "nvchad.options"

local o = vim.o
local opt = vim.opt

-- Better editing experience
o.cursorlineopt = 'both'
o.relativenumber = true
o.number = true
o.scrolloff = 8
o.sidescrolloff = 8
o.updatetime = 250
o.timeoutlen = 300

-- Better search
o.ignorecase = true
o.smartcase = true

-- Better completion. noselect (not noinsert) means the top-ranked candidate
-- is never auto-highlighted, so cmp's <CR> confirm (select = false, see
-- configs/cmp_custom.lua) has nothing to accept even for a strong, obvious
-- match - Enter always just inserts a newline instead. noinsert lets a
-- genuinely top-ranked match (e.g. "app" -> "apple") get highlighted and
-- confirmable by Enter, without previewing/inserting text before that.
opt.completeopt = { 'menu', 'menuone', 'noinsert' }

-- Use the system clipboard for yank/paste by default
opt.clipboard = 'unnamedplus'

-- Better splits
o.splitbelow = true
o.splitright = true

-- Persistent undo
opt.undofile = true
opt.undolevels = 10000

-- Better performance
o.lazyredraw = false

-- Code Folding (Treesitter based)
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldenable = true
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.fillchars = { foldopen = "", foldclose = "", fold = " ", foldsep = " " }


-- Session Management (Persist folds)
opt.sessionoptions = "buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- Show whitespace characters
opt.list = true
opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Disable unused providers
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_python3_provider = 0
-- Indentation Settings
o.expandtab = true      -- Use spaces instead of tabs
o.shiftwidth = 2        -- Shift 2 spaces when tab
o.tabstop = 2           -- 1 tab == 2 spaces
o.softtabstop = 2       -- Edit as if tabs are 2 spaces
o.smartindent = true    -- Insert indents automatically
o.autoindent = true     -- Copy indent from current line when starting a new line
o.smarttab = true       -- Be smart when using tabs
o.breakindent = true    -- Wrapped lines will keep indent
o.showmatch = true      -- Show matching brackets



-- Filetype-specific indentation
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "python", "java" },
  callback = function()
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
    vim.opt_local.softtabstop = 4
  end,
})

