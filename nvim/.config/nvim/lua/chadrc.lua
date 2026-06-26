-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.ui = {
  statusline = {
    theme = "vscode", -- Use neutral 'vscode' theme instead of 'vscode_colored'
  },

  tabufline = {
    lazyload = false,
    enabled = true,
    order = { "buffers", "tabs", "btns" },
  },
}

M.base46 = {
  theme = "catppuccin",

  catppuccin = {
    flavor = "mocha",
  },

  hl_override = {
    Comment = { italic = true },
    ["@comment"] = { italic = true },
    -- Statusline highlight overrides managed in autocmds.lua (ColorScheme event)
    -- to reliably override base46 caching.
  },

}

M.term = {
  winopts = { number = false },
  sizes = { sp = 0.3, vsp = 0.4 },
}

return M
