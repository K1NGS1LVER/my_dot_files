-- Yazi file explorer. Exclusive file manager — no nvim-tree, no neo-tree.
-- <leader>e opens at current file, <leader>cw opens at project root.
-- Replaces netrw for directory opening.
return {
  "mikavilpas/yazi.nvim",
  event = "VeryLazy",
  keys = {
    {
      "<leader>e",
      function() require("yazi").yazi() end,
      desc = "Open yazi at current file",
    },
    {
      "<leader>cw",
      function() require("yazi").yazi(nil, vim.fn.getcwd()) end,
      desc = "Open yazi at project root",
    },
  },
  opts = {
    open_for_directories = true,
    keymaps = { show_help = "<f1>" },
  },
}
