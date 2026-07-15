-- Session persistence, keyed by cwd. Restores window/tab layout and folds
-- (sessionoptions already includes those - see lua/options.lua).
return {
  "folke/persistence.nvim",
  event = "BufReadPre",
  opts = {},
  keys = {
    {
      "<leader>sl",
      function() require("persistence").load() end,
      desc = "Restore last session",
    },
    {
      "<leader>sd",
      function() require("persistence").stop() end,
      desc = "Don't save session on exit",
    },
  },
}
