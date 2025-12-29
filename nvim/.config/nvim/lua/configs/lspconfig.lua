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

vim.lsp.enable(servers)

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
