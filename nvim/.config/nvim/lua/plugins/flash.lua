-- Flash: label-based jump navigation. Replaces sneak/hop patterns.
return {
  "folke/flash.nvim",
  event = "VeryLazy",
  opts = {
    labels = "asdfghjklqwertyuiopzxcvbnm",
    search = { mode = "fuzzy" },
    jump = { autojump = true },
    label = {
      uppercase = false,
      after = true,
      before = false,
      style = "overlay",
    },
  },
  keys = {
    { "s",      mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
    { "S",      mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
    { "r",      mode = "o",               function() require("flash").remote() end,             desc = "Remote Flash" },
    { "R",      mode = { "o", "x" },      function() require("flash").treesitter_search() end,  desc = "Treesitter Search" },
    { "<c-s>",  mode = { "c" },           function() require("flash").toggle() end,             desc = "Toggle Flash Search" },
  },
}
