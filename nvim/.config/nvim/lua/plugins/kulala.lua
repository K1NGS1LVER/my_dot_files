-- Kulala HTTP Client plugin for API testing inside Neovim
return {
  {
    "mistweaverco/kulala.nvim",
    ft = { "http", "rest" },
    opts = {
      default_view = "body",
      treesitter = {
        enable = false,
      },
    },
    keys = {
      { "<leader>R", function() require("kulala").run() end, desc = "Run HTTP Request", ft = { "http", "rest" } },
      { "<leader>Ra", function() require("kulala").run_all() end, desc = "Run All HTTP Requests", ft = { "http", "rest" } },
      { "<leader>Rb", function() require("kulala").scratchpad() end, desc = "Open HTTP Scratchpad" },
    },
  },
}
