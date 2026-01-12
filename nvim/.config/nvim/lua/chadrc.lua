-- This file needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "catppuccin", -- Popular themes: catppuccin, tokyonight, gruvbox, nord
  
  hl_override = {
    Comment = { italic = true },
    ["@comment"] = { italic = true },
  },
  
  transparency = true,
}

M.ui = {
  statusline = {
    theme = "vscode_colored",
  },
  
  tabufline = {
    lazyload = false,
    enabled = true,
    order = { "treeOffset", "buffers", "tabs", "btns" },
  },
}

-- Disable NvimTree offset for Tabufline
M.ui.tabufline.modules = {
  nvimtree = false,
}

M.term = {
  winopts = { number = false },
  sizes = { sp = 0.3, vsp = 0.4 },
}

return M
