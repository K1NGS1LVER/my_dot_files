vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "autocmds"

vim.schedule(function()
  require "mappings"
end)

-- Basic Indentation Settings
vim.opt.expandtab = true -- Converts tabs to spaces
vim.opt.shiftwidth = 2 -- The size of an indent
vim.opt.tabstop = 2 -- The size of a tab
vim.opt.autoindent = true -- Indent at the same level of the previous line
vim.opt.smartindent = true -- Smarter autoindenting (e.g. after braces)

-- PDF Viewer (Sioyek) Integration
vim.api.nvim_create_user_command("Pdf", function(opts)
  local filepath = opts.args
  if filepath == "" then
    filepath = vim.fn.expand "%:p"
  end

  -- CHANGED: Call binary directly with --new-window flag
  vim.fn.jobstart({
    "/Applications/sioyek.app/Contents/MacOS/sioyek",
    "--new-window",
    filepath,
  }, { detach = true })
end, { nargs = "?", complete = "file" })

-- PDF Viewer (Sioyek) Integration
-- vim.api.nvim_create_user_command('Pdf', function(opts)
--   local filepaths = opts.fargs
--   if #filepaths == 0 then
--     filepaths = { vim.fn.expand('%:p') }
--   end
--   for _, filepath in ipairs(filepaths) do
--     vim.fn.jobstart({'open', '-a', '/Applications/sioyek.app', filepath}, {detach = true})
--   end
-- end, { nargs = '*', complete = 'file' })
--
-- Open PDF with default macOS viewer
vim.api.nvim_create_user_command("Openpdf", function(opts)
  local filepath = opts.args
  if filepath == "" then
    filepath = vim.fn.expand "%:p"
  end
  vim.fn.jobstart({ "open", "-a", "/System/Applications/Preview.app", filepath }, { detach = true })
end, { nargs = "?", complete = "file" })

-- --- GX FIX (Smart URL Opener) ---
-- Overrides vim.ui.open to prepend https:// if missing
local original_open = vim.ui.open
vim.ui.open = function(path)
  -- If path has no protocol but looks like a domain (has dot, starts with alphanum)
  -- Regex: Not protocol, starts with word/dash/dot, has a dot followed by letters, optional rest
  if not path:match("^%a+://") and path:match("^[%w%-%.]+%.[a-z]+") then
    path = "https://" .. path
  end
  return original_open(path)
end
require "neovide"
