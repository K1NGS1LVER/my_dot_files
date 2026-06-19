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
    end,
  },
}
