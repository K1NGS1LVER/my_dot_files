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
    order = { "treeOffset", "buffers", "tabs", "btns" },
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

    -- Statusline Mode Indicators (Comprehensive Case Coverage)
    St_NormalMode = { bg = "#6c7086", fg = "#1e1e2e", bold = false },
    St_InsertMode = { bg = "#6c7086", fg = "#1e1e2e", bold = false },
    St_VisualMode = { bg = "#6c7086", fg = "#1e1e2e", bold = false },
    St_CommandMode = { bg = "#6c7086", fg = "#1e1e2e", bold = false },
    St_ReplaceMode = { bg = "#6c7086", fg = "#1e1e2e", bold = false },
    St_TerminalMode = { bg = "#6c7086", fg = "#1e1e2e", bold = false },
    St_NTerminalMode = { bg = "#6c7086", fg = "#1e1e2e", bold = false },

    St_Normalmode = { bg = "#6c7086", fg = "#1e1e2e", bold = false },
    St_Insertmode = { bg = "#6c7086", fg = "#1e1e2e", bold = false },
    St_Visualmode = { bg = "#6c7086", fg = "#1e1e2e", bold = false },
    St_Commandmode = { bg = "#6c7086", fg = "#1e1e2e", bold = false },
    St_Replacemode = { bg = "#6c7086", fg = "#1e1e2e", bold = false },
    St_Terminalmode = { bg = "#6c7086", fg = "#1e1e2e", bold = false },
    St_NTerminalmode = { bg = "#6c7086", fg = "#1e1e2e", bold = false },

    -- Base mode groups
    St_Mode = { bg = "#6c7086", fg = "#1e1e2e", bold = false },
    st_mode = { bg = "#6c7086", fg = "#1e1e2e", bold = false },
    St_mode = { bg = "#6c7086", fg = "#1e1e2e", bold = false },

    -- Statusline Git (Grey)
    St_gitIcons = { fg = "#6c7086", bg = "NONE" },
    St_gitText = { fg = "#6c7086", bg = "NONE" },
    st_gitIcons = { fg = "#6c7086", bg = "NONE" },
    st_gitText = { fg = "#6c7086", bg = "NONE" },

    -- Statusline Diagnostics (Muted Colors)
    St_lspError = { fg = "#a67474", bg = "NONE" },
    St_lspWarning = { fg = "#a69574", bg = "NONE" },
    St_lspHints = { fg = "#748ca6", bg = "NONE" },
    St_lspInfo = { fg = "#748ca6", bg = "NONE" },
    St_LspHints = { fg = "#748ca6", bg = "NONE" },
    St_LspMsg = { fg = "#748ca6", bg = "NONE" },
    st_lspError = { fg = "#a67474", bg = "NONE" },
    st_lspWarning = { fg = "#a69574", bg = "NONE" },

    -- Statusline LSP Server (Grey)
    St_Lsp = { fg = "#6c7086", bg = "NONE" },
    st_lsp = { fg = "#6c7086", bg = "NONE" },

    -- Statusline Folder/CWD (Grey)
    St_cwd = { fg = "#6c7086", bg = "NONE" },
    st_cwd = { fg = "#6c7086", bg = "NONE" },
    St_cwd_icon = { fg = "#6c7086", bg = "NONE" },
    St_cwd_text = { fg = "#6c7086", bg = "NONE" },
    St_cwd_sep = { fg = "#6c7086", bg = "NONE" },
  },

  transparency = true,
}

M.term = {
  winopts = { number = false },
  sizes = { sp = 0.3, vsp = 0.4 },
}

return M
