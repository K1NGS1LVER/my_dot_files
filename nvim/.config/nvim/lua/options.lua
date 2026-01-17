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

-- Better completion
opt.completeopt = { 'menu', 'menuone', 'menuone', 'noselect' }

-- Better splits
o.splitbelow = true
o.splitright = true

-- Persistent undo
opt.undofile = true
opt.undolevels = 10000

-- Better performance
o.lazyredraw = false

-- Code Folding (Icons & Persistence)
opt.foldenable = true
opt.fillchars = { foldopen = "", foldclose = "", fold = " ", foldsep = " " }

-- Session Management (Persist folds)
opt.sessionoptions = "buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- Font configuration (for GUI only)
opt.guifont = "JetBrainsMono Nerd Font:h12"

-- Show whitespace characters
opt.list = true
opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Disable unused providers
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_python3_provider = 0