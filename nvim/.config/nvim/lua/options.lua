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
opt.completeopt = { 'menu', 'menuone', 'noselect' }

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

-- Disable unused providers (Python 3 is kept enabled for molten-nvim)
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_python3_provider = nil

-- Notebook stack (molten/jupytext/quarto) runs on a pinned venv, not the
-- floating brew python3, so brew upgrades cannot break it underneath us.
-- See scripts/setup-notebook-env and nvim/.config/nvim/python-requirements.txt.
local notebook_venv_python = vim.fn.expand("~/.venvs/nvim/bin/python")
if vim.uv.fs_stat(notebook_venv_python) then
  vim.g.python3_host_prog = notebook_venv_python
else
  vim.g.python3_host_prog = "/opt/homebrew/bin/python3"
  vim.schedule(function()
    vim.notify(
      "Notebook venv not found at ~/.venvs/nvim. Run scripts/setup-notebook-env "
        .. "to fix molten/jupytext. Falling back to system python3 for now.",
      vim.log.levels.WARN,
      { title = "nvim python provider" }
    )
  end)
end
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

