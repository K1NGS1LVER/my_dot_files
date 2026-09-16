-- Notebook integration for Neovim
-- Based on molten-nvim official Notebook-Setup.md and jupytext.nvim
return {
  -- Transparent .ipynb <-> Python script conversion via Jupytext
  {
    "GCBallesteros/jupytext.nvim",
    lazy = false,
    opts = {
      style = "percent",
      output_extension = "py",
      force_ft = "python",
    },
  },

  -- Interactive Jupyter cell runner and output viewer
  {
    "benlubas/molten-nvim",
    version = "^1.0.0",
    build = ":UpdateRemotePlugins",
    ft = { "python", "markdown" },
    init = function()
      vim.g.molten_auto_open_output = false
      vim.g.molten_output_win_max_height = 16
      vim.g.molten_output_win_cover_gutter = false
      vim.g.molten_wrap_output = true
      vim.g.molten_virt_text_output = true
    end,
    keys = {
      { "<leader>mi", "<cmd>MoltenInit pythonvishal<cr>", desc = "Molten: Initialize pythonVishal Kernel" },
      { "<leader>mI", "<cmd>MoltenInit<cr>", desc = "Molten: Select Kernel Prompt" },
      { "<leader>mc", "<cmd>MoltenReevaluateCell<cr>", desc = "Molten: Run Cell" },
      { "<leader>ml", "<cmd>MoltenEvaluateLine<cr>", desc = "Molten: Run Line" },
      { "<leader>mv", "<cmd>MoltenEvaluateVisual<cr>", mode = "v", desc = "Molten: Run Selection" },
      { "<leader>md", "<cmd>MoltenDelete<cr>", desc = "Molten: Delete Output" },
      { "<leader>mx", "<cmd>MoltenOpenInBrowser<cr>", desc = "Molten: View Output in Browser" },
    },
  },
}
