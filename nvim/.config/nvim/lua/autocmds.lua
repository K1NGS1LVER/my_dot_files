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

