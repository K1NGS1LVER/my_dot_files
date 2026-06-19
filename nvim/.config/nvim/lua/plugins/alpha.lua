-- Dashboard greeter. Overrides NvChad's default with custom ASCII art.
-- Config lives in configs/alpha.lua.
return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("alpha").setup(require("configs.alpha"))
  end,
}
