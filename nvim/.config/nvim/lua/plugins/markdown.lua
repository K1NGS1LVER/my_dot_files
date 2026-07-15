-- Markdown ecosystem: rich rendering + table alignment.
-- Both plugins share the same filetype trigger for efficient lazy-loading.
return {
  -- Render headings, code blocks, checkboxes inline
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      { "<leader>rm", "<cmd>RenderMarkdown toggle<cr>", desc = "Toggle Render Markdown" },
    },
    opts = {
      code = { sign = false, width = "block", right_pad = 1 },
      heading = { sign = false, icons = {} },
    },
  },

  -- Automatic table formatting with |pipes|
  {
    "dhruvasagar/vim-table-mode",
    ft = { "markdown" },
    init = function()
      vim.g.table_mode_syntax_check = 0
      vim.g.table_mode_corner = "|"
      -- vim-table-mode's default Tableize map is <leader>tt, which silently
      -- overwrites our own transparency-toggle mapping (also <leader>tt) as
      -- soon as this ft={"markdown"} plugin lazy-loads. Move it out of our
      -- <leader>t* namespace entirely; every other table-mode default
      -- (tr/tdd/tdc/tiC/tic/tfa/tfe/t?/ts/tm) is left alone since none of
      -- those collide with anything else in this config.
      vim.g.table_mode_tableize_map = "<Leader>T"
    end,
  },
}
