vim.loader.enable()
vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

-- Bootstrap lazy.nvim (stable branch pinned)
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- Load NvChad core + all per-plugin specs from lua/plugins/*.lua
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },
  { import = "plugins" },
}, lazy_config)

-- Load base46 theme cache
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "autocmds"

vim.schedule(function()
  require "mappings"
end)

-- PDF Viewer (Sioyek) Integration
vim.api.nvim_create_user_command("Pdf", function(opts)
  local filepath = opts.args
  if filepath == "" then
    filepath = vim.fn.expand "%:p"
  end
  vim.fn.jobstart({
    "/Applications/sioyek.app/Contents/MacOS/sioyek",
    "--new-window",
    filepath,
  }, { detach = true })
end, { nargs = "?", complete = "file" })

-- Open PDF with default macOS viewer
vim.api.nvim_create_user_command("Openpdf", function(opts)
  local filepath = opts.args
  if filepath == "" then
    filepath = vim.fn.expand "%:p"
  end
  vim.fn.jobstart({ "open", "-a", "/System/Applications/Preview.app", filepath }, { detach = true })
end, { nargs = "?", complete = "file" })

-- GX Fix: prepend https:// to bare domain URLs
local original_open = vim.ui.open
vim.ui.open = function(path)
  if not path:match "^%a+://" and path:match "^[%w%-%.]+%.[a-z]+" then
    path = "https://" .. path
  end
  return original_open(path)
end

require "neovide"
