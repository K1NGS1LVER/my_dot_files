-- Set mapleader early
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Global transparency state
vim.g.transparency_enabled = true

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
      -- Mini.basics: Sets up vim.opt and basic mappings
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
        window = {
          info = { height = 25, width = 80, border = 'rounded' },
          signature = { height = 25, width = 80, border = 'rounded' },
        },
      })
      require("mini.cursorword").setup()
      require("mini.diff").setup({
        view = { style = "sign", signs = { add = "│", change = "│", delete = "_" } },
      })
      require("mini.extra").setup()
      require("mini.files").setup({ windows = { preview = true, width_preview = 80 } })
      require("mini.git").setup()
      require("mini.icons").setup()
      if _G.MiniIcons then MiniIcons.mock_nvim_web_devicons() end

      require("mini.indentscope").setup({
        symbol = "│",
        draw = { animation = require("mini.indentscope").gen_animation.none() },
      })
      require("mini.jump2d").setup({
        mappings = { start_jumping = 's' },
        view = { dim = true },
      })
      require("mini.move").setup({
        mappings = {
          left = '<M-h>', right = '<M-l>', down = '<M-j>', up = '<M-k>',
          line_left = '<M-h>', line_right = '<M-l>', line_down = '<M-j>', line_up = '<M-k>',
        },
      })
      require("mini.notify").setup()
      vim.notify = require("mini.notify").make_notify()
      require("mini.pairs").setup()
      require("mini.pick").setup({ mappings = { move_down = '<C-n>', move_up = '<C-p>' } })
      require("mini.sessions").setup({ autoread = false, autowrite = true })
      require("mini.starter").setup()
      require("mini.statusline").setup()
      require("mini.surround").setup()
      require("mini.tabline").setup()
      require("mini.trailspace").setup()
      require("mini.visits").setup()
    end,
  },

  -- Treesitter for highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSUpdateSync", "TSUpdate" },
    config = function()
      local status, ts = pcall(require, "nvim-treesitter.configs")
      if status then
        ts.setup({
          ensure_installed = { "lua", "vim", "vimdoc", "markdown", "markdown_inline", "c", "python", "javascript", "typescript", "go", "rust" },
          highlight = { enable = true },
          indent = { enable = true },
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
      mlsp.setup({ ensure_installed = { "lua_ls" } })

      local lspconfig = require("lspconfig")
      local capabilities = vim.lsp.protocol.make_client_capabilities()

      local on_attach = function(client, bufnr)
        local opts = { buffer = bufnr, noremap = true, silent = true }
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<leader>lf', function() vim.lsp.buf.format { async = true } end, opts)
      end

      if mlsp.setup_handlers then
        mlsp.setup_handlers({
          function(server_name)
            lspconfig[server_name].setup({ on_attach = on_attach, capabilities = capabilities })
          end,
        })
      else
        lspconfig.lua_ls.setup({ on_attach = on_attach, capabilities = capabilities })
      end
    end,
  },

  -- Theme: Catppuccin with Transparency support
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({ 
        flavour = "mocha",
        transparent_background = vim.g.transparency_enabled,
        integrations = {
          mini = { enabled = true },
          native_lsp = { enabled = true },
          treesitter = true,
        }
      })
      vim.cmd.colorscheme "catppuccin"
    end,
  }
})

-- ========================================================================== --
--                            CUSTOM MAPPINGS                                 --
-- ========================================================================== --

local map = vim.keymap.set

-- Transparency Toggle (from your main config)
map("n", "<leader>tt", function()
  vim.g.transparency_enabled = not vim.g.transparency_enabled
  require("catppuccin").setup({ transparent_background = vim.g.transparency_enabled })
  vim.cmd("colorscheme catppuccin")
  print("Transparency: " .. tostring(vim.g.transparency_enabled))
end, { desc = "Toggle Transparency" })

-- Mini.Files
map("n", "<leader>e", function() 
  if _G.MiniFiles then
    if not MiniFiles.close() then MiniFiles.open() end 
  end
end, { desc = "Toggle Mini Files" })

-- Mini.Pick
map("n", "<leader>ff", "<cmd>Pick files<cr>", { desc = "Find Files" })
map("n", "<leader>fw", "<cmd>Pick grep_live<cr>", { desc = "Live Grep" })
map("n", "<leader>fb", "<cmd>Pick buffers<cr>", { desc = "Find Buffers" })
map("n", "<leader>fh", "<cmd>Pick help<cr>", { desc = "Help Tags" })

-- General
map("n", "<C-s>", "<cmd>w<cr>", { desc = "Save" })
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save" })
map("n", "<leader>qq", "<cmd>q<cr>", { desc = "Quit" })
map("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "Clear Search Highlights" })

-- Better indenting
map("v", "<", "<gv", { desc = "Indent Left" })
map("v", ">", ">gv", { desc = "Indent Right" })

-- Window Resizing
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- PDF Viewer
vim.api.nvim_create_user_command("Pdf", function(opts)
  local filepath = opts.args == "" and vim.fn.expand("%:p") or opts.args
  vim.fn.jobstart({ "/Applications/sioyek.app/Contents/MacOS/sioyek", "--new-window", filepath }, { detach = true })
end, { nargs = "?", complete = "file" })

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
o.splitbelow = true
o.splitright = true
o.termguicolors = true
