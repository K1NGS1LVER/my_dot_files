-- Yazi file explorer: Miller columns, instant previews, native terminal TUI.
-- Fully optimized: lazy-loaded on VeryLazy, 0ms startup penalty.
return {
  "mikavilpas/yazi.nvim",
  event = "VeryLazy",
  keys = {
    {
      "<leader>e",
      "<cmd>Yazi<cr>",
      desc = "Open yazi at current file",
    },
    {
      "<leader>cw",
      "<cmd>Yazi cwd<cr>",
      desc = "Open yazi at project root",
    },
    {
      "<C-Up>",
      "<cmd>Yazi toggle<cr>",
      desc = "Resume last yazi session",
    },
  },
  opts = {
    open_for_directories = true,
    keymaps = {
      show_help = "<f1>",
    },
    floating_window_scaling_factor = 0.9,
    yazi_floating_window_winblend = 0,
  },
}
