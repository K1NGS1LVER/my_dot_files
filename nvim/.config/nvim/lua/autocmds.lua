require "nvchad.autocmds"

local autocmd = vim.api.nvim_create_autocmd

-- Toggle relative line numbers based on mode
autocmd("InsertEnter", {
  callback = function()
    vim.opt.relativenumber = false
  end,
})

autocmd("InsertLeave", {
  callback = function()
    vim.opt.relativenumber = true
  end,
})

-- Markdown: conceallevel so render-markdown.nvim's inline rendering
-- (bold/italic/links/code markers) actually hides raw syntax instead of
-- just rendering block-level icons on top of it - render-markdown.nvim
-- manages concealcursor itself dynamically, no need to set that here.
-- linebreak + breakindent give word-boundary prose wrapping instead of
-- mid-word wrap at the window edge; spellcheck is standard for prose.
autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt_local.conceallevel = 2
    vim.opt_local.linebreak = true
    vim.opt_local.breakindent = true
    vim.opt_local.spell = true
    vim.opt_local.spelllang = "en_us"
  end,
})

-- Show diagnostic float on cursor hold
autocmd("CursorHold", {
  callback = function()
    vim.diagnostic.open_float(nil, {
      focusable = false,
      close_events = { "CursorMoved", "CursorMovedI", "BufLeave", "InsertEnter" },
      border = "rounded",
      source = true,
      prefix = " ",
      scope = "line",
    })
  end,
})

-- Native transparency enforcement. Replaces transparent.nvim plugin.
-- Gated behind vim.g.transparency_enabled for <leader>tt toggle support.
vim.g.transparency_enabled = true

autocmd({ "VimEnter", "ColorScheme" }, {
  callback = function()
    if not vim.g.transparency_enabled then return end

    local clear_groups = {
      -- Core editor
      "Normal", "NormalNC", "NormalFloat", "FloatBorder", "FloatTitle",
      "SignColumn", "FoldColumn", "LineNr", "CursorLineNr",
      "EndOfBuffer", "MsgArea",

      -- Status / tab / winbar
      "StatusLine", "StatusLineNC",
      "TabLine", "TabLineFill",
      "WinBar", "WinBarNC", "WinSeparator", "VertSplit",

      -- Popup menu
      "Pmenu", "PmenuSbar",

      -- Telescope
      "TelescopeNormal", "TelescopeBorder",
      "TelescopePromptNormal", "TelescopePromptBorder",
      "TelescopeResultsNormal", "TelescopeResultsBorder",
      "TelescopePreviewNormal", "TelescopePreviewBorder",
    }

    for _, group in ipairs(clear_groups) do
      local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = group })
      if ok then
        hl.bg = nil
        hl.ctermbg = nil
        pcall(vim.api.nvim_set_hl, 0, group, hl)
      end
    end
  end,
})

-- Muted statusline colors, derived from the active colorscheme's own
-- highlight groups so the look adapts across themes (switch-theme cycles
-- through 6 unrelated palettes). Falls back to the original Catppuccin-ish
-- hardcoded hexes only if a highlight group is missing its color entirely.
local function hl_hex(name, attr, fallback)
  local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = name, link = false })
  if ok and hl and hl[attr] then
    return string.format("#%06x", hl[attr])
  end
  return fallback
end

-- Force grey statusline (Bypass NvChad base46 caching)
autocmd({ "VimEnter", "ColorScheme" }, {
  callback = function()
    local grey = hl_hex("Comment", "fg", "#6c7086")
    local bg = hl_hex("Normal", "bg", "#1e1e2e")
    local muted_red = hl_hex("DiagnosticError", "fg", "#a67474")
    local muted_gold = hl_hex("DiagnosticWarn", "fg", "#a69574")

    local groups = {
      -- Normal Mode
      St_NormalMode = { bg = grey, fg = bg, bold = false },
      St_Normalmode = { bg = grey, fg = bg, bold = false },
      -- Insert Mode
      St_InsertMode = { bg = grey, fg = bg, bold = false },
      St_Insertmode = { bg = grey, fg = bg, bold = false },
      -- Visual Mode
      St_VisualMode = { bg = grey, fg = bg, bold = false },
      St_Visualmode = { bg = grey, fg = bg, bold = false },
      -- Other Modes
      St_CommandMode = { bg = grey, fg = bg, bold = false },
      St_Commandmode = { bg = grey, fg = bg, bold = false },
      St_TerminalMode = { bg = grey, fg = bg, bold = false },
      St_Terminalmode = { bg = grey, fg = bg, bold = false },
      St_NTerminalMode = { bg = grey, fg = bg, bold = false },
      St_NTerminalmode = { bg = grey, fg = bg, bold = false },

      -- Git status
      St_gitIcons = { fg = grey },
      St_gitText = { fg = grey },

      -- Diagnostics (Muted)
      St_lspError = { fg = muted_red },
      St_lspWarning = { fg = muted_gold },
      St_lspHints = { fg = grey },
      St_lspInfo = { fg = grey },
      St_LspHints = { fg = grey },
      St_LspMsg = { fg = grey },

      -- LSP and Folder
      St_Lsp = { fg = grey },
      St_cwd = { fg = grey },
      St_cwd_icon = { fg = grey },
      St_cwd_text = { fg = grey },
    }

    for group, opts in pairs(groups) do
      vim.api.nvim_set_hl(0, group, opts)
    end
  end,
})
