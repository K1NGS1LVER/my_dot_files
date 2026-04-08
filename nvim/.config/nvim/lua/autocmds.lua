require "nvchad.autocmds"

local autocmd = vim.api.nvim_create_autocmd

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

-- Automatically show diagnostic floating window on hover (CursorHold)
autocmd("CursorHold", {
  callback = function()
    local opts = {
      focusable = false,
      close_events = { "CursorMoved", "CursorMovedI", "BufLeave", "InsertEnter" },
      border = "rounded",
      source = "always",
      prefix = " ",
      scope = "line", -- Show all diagnostics on the current line
    }
    vim.diagnostic.open_float(nil, opts)
  end,
})

-- Force Grey Statusline (Bypass NvChad Caching)
autocmd({ "VimEnter", "ColorScheme" }, {
  callback = function()
    local grey = "#6c7086"
    local bg = "#1e1e2e"
    local muted_red = "#a67474"
    local muted_gold = "#a69574"

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

