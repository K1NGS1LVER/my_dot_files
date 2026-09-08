-- LSP infrastructure. Mason provides server binaries; lspconfig wires them up.
-- Server list and per-server tweaks live in configs/lspconfig.lua.
--
-- mason-tool-installer ensures the mason-managed server binaries below are
-- actually installed, so a missing binary fails loudly (an install attempt)
-- instead of silently producing "no LSP attached". gopls and rust_analyzer
-- are deliberately excluded: they are installed system-wide via Brewfile.
return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    require("mason").setup()
    require("mason-tool-installer").setup {
      ensure_installed = {
        "pyright",
        "ruff",
        "lua-language-server",
        "bash-language-server",
        "json-lsp",
        "typescript-language-server",
      },
      run_on_start = false,
    }
    require("configs.lspconfig")
  end,
}
