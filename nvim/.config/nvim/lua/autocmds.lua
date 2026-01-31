require "nvchad.autocmds"

local vim = vim
local autocmd = vim.api.nvim_create_autocmd

-- Markdown specific settings
autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.conceallevel = 2
  end,
})

-- Smart Line Numbers (Absolute in Insert, Relative in Normal)
local number_toggle_group = vim.api.nvim_create_augroup("NumberToggle", { clear = true })

autocmd({ "BufEnter", "FocusGained", "InsertLeave", "WinEnter" }, {
  group = number_toggle_group,
  callback = function()
    if vim.opt.number:get() and vim.api.nvim_get_mode().mode ~= "i" then
      vim.opt.relativenumber = true
    end
  end,
})

autocmd({ "BufLeave", "FocusLost", "InsertEnter", "WinLeave" }, {
  group = number_toggle_group,
  callback = function()
    if vim.opt.number:get() then
      vim.opt.relativenumber = false
    end
  end,
})

-- Universal Transparency Enforcer
-- This ensures ANY theme loaded will have transparent backgrounds
-- local transparency_group = vim.api.nvim_create_augroup("UniversalTransparency", { clear = true })

-- -- Default to true if not set
-- if vim.g.transparency_enabled == nil then
--   vim.g.transparency_enabled = true
-- end

-- local function set_transparency()
--   if not vim.g.transparency_enabled then return end
  
--   -- 2. Clear Highlights
--   local groups = {
--     "Normal", "NormalNC", "Comment", "Constant", "Special", "Identifier",
--     "Statement", "PreProc", "Type", "Underlined", "Todo", "String", "Function",
--     "Conditional", "Repeat", "Operator", "Structure", "LineNr", "NonText",
--     "SignColumn", "CursorLineNr", "EndOfBuffer", "MsgArea",
--     "NormalFloat", "FloatBorder", "NvimTreeNormal", "NvimTreeNormalNC", "NvimTreeWinSeparator",
--     "TelescopeNormal", "TelescopeBorder", "TelescopePromptNormal", "TelescopePromptBorder",
--     "Pmenu", "PmenuSel", "PmenuSbar", "PmenuThumb",
--     "GitSignsAdd", "GitSignsChange", "GitSignsDelete",
--   }
  
--   for _, group in ipairs(groups) do
--     vim.api.nvim_set_hl(0, group, { bg = "NONE" })
--   end
-- end

-- autocmd("ColorScheme", {
--   group = transparency_group,
--   pattern = "*",
--   callback = set_transparency,
-- })

-- -- Apply immediately if a theme is already loaded
-- set_transparency()
-- Go specific settings (Force Real Tabs)
autocmd("FileType", {
  pattern = "go",
  callback = function()
    vim.opt_local.expandtab = false  -- Use real tabs
    vim.opt_local.tabstop = 4        -- Visual width of tab
    vim.opt_local.shiftwidth = 4     -- Indent width
    vim.opt_local.softtabstop = 4
  end,
})

