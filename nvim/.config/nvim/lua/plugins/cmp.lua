-- Completion engine. Sources: LSP, snippets, buffer, path.
-- Copilot integration handled via Tab/C-l fallback chain.
-- Config lives in configs/cmp_custom.lua.
return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "saadparwaiz1/cmp_luasnip",
  },
  config = function()
    require("configs.cmp_custom")
  end,
}
