-- LSP infrastructure. Mason provides server binaries; lspconfig wires them up.
-- Server list and per-server tweaks live in configs/lspconfig.lua.
return {
  "neovim/nvim-lspconfig",
  dependencies = { "williamboman/mason.nvim" },
  config = function()
    require("mason").setup()
    require("configs.lspconfig")
  end,
}
