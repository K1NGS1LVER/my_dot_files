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

-- Font configuration (for GUI only)
opt.guifont = "JetBrainsMono Nerd Font:h12"

-- Show whitespace characters
opt.list = true
opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }