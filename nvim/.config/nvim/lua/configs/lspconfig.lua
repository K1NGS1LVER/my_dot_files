local nvlsp = require "nvchad.configs.lspconfig"

-- 1. Base config applied to all LSP servers (Neovim 0.11/0.12 native API)
vim.lsp.config("*", {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
})

-- 2. Server-specific configurations
vim.lsp.config("pyright", {
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "off",
      },
    },
  },
})

vim.lsp.config("ruff", {
  on_attach = function(client, bufnr)
    client.server_capabilities.hoverProvider = false
    nvlsp.on_attach(client, bufnr)
  end,
})

-- 3. Lean server list
local servers = {
  "lua_ls",
  "pyright",
  "ruff",
  "gopls",
  "rust_analyzer",
  "bashls",
  "jsonls",
  "ts_ls",
}

-- 4. Enable servers
vim.lsp.enable(servers)

-- 5. Diagnostic Styling
vim.diagnostic.config {
  virtual_text = false,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = "rounded",
    wrap = true,
    max_width = 80,
    source = true,
    header = "",
    prefix = "",
  },
}
