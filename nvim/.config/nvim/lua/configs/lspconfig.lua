local nvlsp = require "nvchad.configs.lspconfig"

-- Get base config from NvChad
local base_config = {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
}

-- Servers to enable
local servers = {
  "html",
  "cssls",
  "eslint",
  "jsonls",
  "yamlls",
  "bashls",
  "dockerls",
  "pyright",
  "ruff",
  "vtsls",
  "rust_analyzer",
  "gopls",
  "lua_ls",
  "kotlin_language_server",
  "jdtls",
  "lemminx",
}

-- Loop and configure using the NEW Neovim 0.11 API
for _, name in ipairs(servers) do
  local config = vim.tbl_deep_extend("force", {}, base_config)

  -- Pyright Optimization
  if name == "pyright" then
    config.settings = {
      python = {
        analysis = {
          typeCheckingMode = "off",
          autoSearchPaths = true,
          useLibraryCodeForTypes = true,
          diagnosticMode = "workspace",
        },
      },
    }
  end

  -- Ruff Optimization (Disable hover to let Pyright handle it)
  if name == "ruff" then
    config.on_attach = function(client, bufnr)
      client.server_capabilities.hoverProvider = false
      nvlsp.on_attach(client, bufnr)
    end
  end

  -- Vtsls root detection
  if name == "vtsls" then
    config.root_markers = { 'tsconfig.json', 'jsconfig.json', 'package.json', '.git' }
  end

  -- APPLY CONFIG (Neovim 0.11 Way)
  vim.lsp.config[name] = config
  vim.lsp.enable(name)
end

-- Diagnostic Config
vim.diagnostic.config({
  virtual_text = { prefix = "●", spacing = 4 },
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
  float = { border = "rounded", source = "always", header = "", prefix = "" },
})
