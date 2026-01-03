require("nvchad.configs.lspconfig").defaults()

-- List of language servers to enable
-- Install them using :MasonInstall <server_name>
local servers = {
  "html",
  "cssls",
  "ts_ls",        -- TypeScript/JavaScript
  "eslint",       -- ESLint
  "jsonls",       -- JSON
  "yamlls",       -- YAML
  "bashls",       -- Bash
  "dockerls",     -- Docker
  "pyright",      -- Python
  "rust_analyzer",-- Rust
  "gopls",        -- Go
  "lua_ls",       -- Lua
}

-- Use the existing NvChad or global enable function
if vim.lsp.enable then
  vim.lsp.enable(servers)
else
  -- Fallback if vim.lsp.enable isn't found (though it should be if it was there before)
  -- This handles the case where NvChad might inject it
  for _, lsp in ipairs(servers) do
    local lspconf = require "lspconfig"
    lspconf[lsp].setup {
      on_attach = require("nvchad.configs.lspconfig").on_attach,
      on_init = require("nvchad.configs.lspconfig").on_init,
      capabilities = require("nvchad.configs.lspconfig").capabilities,
    }
  end
end

-- Enhanced diagnostic configuration
vim.diagnostic.config({
  virtual_text = {
    prefix = "●",
    spacing = 4,
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "󰅚 ",
      [vim.diagnostic.severity.WARN] = "󰀪 ",
      [vim.diagnostic.severity.HINT] = "󰌶 ",
      [vim.diagnostic.severity.INFO] = " ",
    },
  },
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
})