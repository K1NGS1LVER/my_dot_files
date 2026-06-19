-- Distraction-free writing. Tmux status bar auto-hidden on enter/exit.
return {
  "folke/zen-mode.nvim",
  cmd = "ZenMode",
  keys = {
    { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" },
  },
  opts = {
    plugins = {
      gitsigns = true,
      tmux = { enabled = true },
      kitty = { enabled = false, font = "+4" },
    },
    on_close = function()
      vim.fn.system("tmux set status on")
      vim.cmd("silent! !tmux resize-pane -Z")
    end,
  },
}
