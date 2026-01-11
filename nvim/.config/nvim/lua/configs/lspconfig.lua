local nvlsp = require "nvchad.configs.lspconfig"

nvlsp.defaults()

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
  "kotlin_language_server", -- Kotlin
  "jdtls",        -- Java
  "lemminx",      -- XML
}

-- Helper to find Mason binaries
local function get_mason_bin(server_name)
    return vim.fn.stdpath("data") .. "/mason/bin/" .. server_name
end

-- Ensure lspconfig configs are loaded for Nvim 0.11 defaults
-- This prevents "module 'lspconfig' not found" errors if we rely on it
pcall(require, "lspconfig.configs")

for _, lsp in ipairs(servers) do
  local config = {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }

  -- Special handling for ts_ls (TypeScript)
  if lsp == "ts_ls" then
      -- Use root_markers for correct per-project detection (Nvim 0.11+)
      config.root_markers = { 'tsconfig.json', 'jsconfig.json', 'package.json', '.git' }
      
      -- Ensure we use the mason binary if available
      local binary = get_mason_bin("typescript-language-server")
      if vim.fn.executable(binary) == 1 then
          config.cmd = { binary, "--stdio" }
      end
  end

  -- Special handling for Kotlin
  if lsp == "kotlin_language_server" then
      local binary = get_mason_bin("kotlin-language-server")
      if vim.fn.executable(binary) == 1 then
          config.cmd = { binary }
      end
  end

  -- Native Neovim 0.11+ Setup
  if vim.lsp.enable then
      vim.lsp.config[lsp] = config
      vim.lsp.enable(lsp)
  else
      -- Fallback for older versions (unlikely given the error, but safe)
      require("lspconfig")[lsp].setup(config)
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