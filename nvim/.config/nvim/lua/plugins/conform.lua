-- Formatter engine. Triggers format-on-save via BufWritePre.
-- :Format user command for manual/range formatting.
return {
  "stevearc/conform.nvim",
  event = "BufWritePre",
  cmd = { "Format" },
  config = function()
    require("conform").setup(require("configs.conform"))

    -- :Format command for manual/range formatting
    vim.api.nvim_create_user_command("Format", function(args)
      local range = nil
      if args.count ~= -1 then
        local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
        range = {
          start = { args.line1, 0 },
          ["end"] = { args.line2, end_line:len() },
        }
      end
      require("conform").format({ async = true, lsp_fallback = true, range = range })
    end, { range = true })
  end,
}
