-- Set mapleader early
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Global transparency state
vim.g.transparency_enabled = true

-- Basic Options
local o = vim.o
o.number = true
o.relativenumber = true
o.expandtab = true
o.shiftwidth = 2
o.tabstop = 2
o.smartindent = true
o.ignorecase = true
o.smartcase = true
o.termguicolors = true
o.splitbelow = true
o.splitright = true

-- Install lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- The Core: Mini.nvim
  {
    "echasnovski/mini.nvim",
    version = "*",
    config = function()
      require("mini.basics").setup({
        options = { basic = true, extra_ui = true, win_borders = "default" },
        mappings = { basic = true, option_toggle_prefix = [[<leader>t]], windows = true, move_with_alt = true },
        autocommands = { basic = true, relnum_in_visual_mode = true },
      })
      require("mini.ai").setup()
      require("mini.align").setup()
      require("mini.bracketed").setup()
      require("mini.bufremove").setup()
      require("mini.comment").setup()
      require("mini.completion").setup({
        lsp_completion = { source_func = "completefunc", auto_setup = false },
      })
      require("mini.cursorword").setup()
      require("mini.diff").setup({ view = { style = "sign" } })
      require("mini.extra").setup()
      require("mini.files").setup({ windows = { preview = true, width_preview = 80 } })
      require("mini.git").setup()
      require("mini.icons").setup()
      if _G.MiniIcons then MiniIcons.mock_nvim_web_devicons() end
      require("mini.indentscope").setup({ symbol = "│", draw = { animation = require("mini.indentscope").gen_animation.none() } })
      require("mini.jump2d").setup({ mappings = { start_jumping = 's' } })
      require("mini.move").setup({
        mappings = {
          left = '<M-h>', right = '<M-l>', down = '<M-j>', up = '<M-k>',
          line_left = '<M-h>', line_right = '<M-l>', line_down = '<M-j>', line_up = '<M-k>',
        },
      })
      require("mini.notify").setup()
      vim.notify = require("mini.notify").make_notify()
      require("mini.pairs").setup()
      require("mini.pick").setup()
      require("mini.sessions").setup({ autoread = false, autowrite = true })
      require("mini.starter").setup()
      require("mini.statusline").setup()
      require("mini.surround").setup()
      require("mini.tabline").setup()
      require("mini.trailspace").setup()
      require("mini.visits").setup()

      -- Custom mappings for MiniFiles
      vim.api.nvim_create_autocmd('User', {
        pattern = 'MiniFilesBufferCreate',
        callback = function(args)
          local buf_id = args.data.buf_id
          vim.keymap.set('n', '<CR>', function() MiniFiles.go_in({ close_on_file = true }) end, { buffer = buf_id })
        end,
      })
    end,
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      local status, ts = pcall(require, "nvim-treesitter.configs")
      if status then
        ts.setup({
          ensure_installed = { 
            "lua", "vim", "vimdoc", "markdown", "markdown_inline", 
            "python", "javascript", "typescript", "go", "rust", 
            "html", "css", "c", "cpp" 
          },
          highlight = { enable = true },
        })
      end
    end,
  },

  -- LSP Support
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      require("mason").setup()
      local mlsp = require("mason-lspconfig")
      
      local servers = {
        "html", "cssls", "pyright", "ruff", "gopls", "rust_analyzer",
        "lua_ls", "kotlin_language_server", "jdtls", "bashls", "jsonls",
        "ts_ls", "eslint", "clangd"
      }
      
      mlsp.setup({ ensure_installed = servers })

      local on_attach = function(_, bufnr)
        local opts = { buffer = bufnr, noremap = true, silent = true }
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
      end

      -- The stable Neovim 0.11 API pattern
      for _, name in ipairs(servers) do
        local opts = { on_attach = on_attach }
        
        if name == "pyright" then
          opts.settings = { python = { analysis = { typeCheckingMode = "off" } } }
        end

        local status, config = pcall(function() return vim.lsp.config[name] end)
        if status and config then
          config.setup(opts)
        end
      end
    end,
  },

  -- Theme
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({ flavour = "mocha", transparent_background = vim.g.transparency_enabled })
      vim.cmd.colorscheme "catppuccin"
    end,
  }
})

-- Mappings
local map = vim.keymap.set

-- Terminal
map("n", "<leader>h", "<cmd>split | term<cr>i", { desc = "Horizontal Terminal" })
map("n", "<leader>v", "<cmd>vsplit | term<cr>i", { desc = "Vertical Terminal" })
map("t", "jk", [[<C-\><C-n>]], { desc = "Exit terminal mode" })

-- Transparency
map("n", "<leader>tt", function()
  vim.g.transparency_enabled = not vim.g.transparency_enabled
  require("catppuccin").setup({ transparent_background = vim.g.transparency_enabled })
  vim.cmd("colorscheme catppuccin")
end, { desc = "Toggle Transparency" })

-- Mini.Files
map("n", "<leader>e", function() 
  if _G.MiniFiles then 
    if not MiniFiles.close() then 
      local path = vim.api.nvim_buf_get_name(0)
      if path == "" or vim.fn.filereadable(path) == 0 then path = vim.fn.getcwd() end
      MiniFiles.open(path) 
    end 
  end
end, { desc = "Toggle Mini Files" })

-- Mini.Pick
map("n", "<leader>ff", "<cmd>Pick files<cr>", { desc = "Find Files" })
map("n", "<leader>fw", "<cmd>Pick grep_live<cr>", { desc = "Live Grep" })
map("n", "<C-s>", "<cmd>w<cr>", { desc = "Save" })
map("n", "<leader>qq", "<cmd>q<cr>", { desc = "Quit" })
map("n", "<Esc>", "<cmd>nohlsearch<cr>")
