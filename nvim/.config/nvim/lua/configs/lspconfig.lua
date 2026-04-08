local nvlsp = require "nvchad.configs.lspconfig"

-- 1. ADD MASON TO PATH
local mason_path = vim.fn.stdpath "data" .. "/mason/bin"
vim.env.PATH = mason_path .. ":" .. vim.env.PATH

-- 2. Base Config
local base_config = {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
}

-- 3. List of Servers (Manage this list to enable/disable)
local servers = {
  "html",
  "cssls",
  "clangd",
  "pyright",
  "ruff",
  "gopls",
  "rust_analyzer",
  "lua_ls",
  "kotlin_language_server",
  "jdtls",
  "bashls",
  "jsonls",
  "ts_ls",
  "eslint",
}

-- 4. Enable Servers (The Neovim 0.11 Way)
for _, name in ipairs(servers) do
  local opts = vim.tbl_deep_extend("force", {}, base_config)

  -- Specific Server Tweaks
  if name == "pyright" then
    opts.settings = { python = { analysis = { typeCheckingMode = "off" } } }
  end

  if name == "ruff" then
    opts.on_attach = function(client, bufnr)
      client.server_capabilities.hoverProvider = false
      nvlsp.on_attach(client, bufnr)
    end
  end

  -- This is the native Neovim 0.11 API
  -- It's more stable than setup_handlers
  vim.lsp.config[name] = opts
  vim.lsp.enable(name)
end

-- Diagnostic Styling
vim.diagnostic.config {
  -- virtual_text = {
  --   prefix = '●', -- Or '■', '▎', 'x'
  --   spacing = 4,
  -- },
  virtual_text = false,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = "rounded",
    wrap = true,
    max_width = 80,
    source = "always", -- Show the source (e.g., Pyright, ESLint)
    header = "",
    prefix = "",
  },
}
