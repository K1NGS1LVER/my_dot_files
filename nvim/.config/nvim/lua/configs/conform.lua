local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    javascript = { "prettier" },
    typescript = { "prettier" },
    javascriptreact = { "prettier" },
    typescriptreact = { "prettier" },
    css = { "prettier" },
    html = { "prettier" },
    json = { "prettier" },
    yaml = { "prettier" },
    markdown = { "prettier" },
    -- Python Optimization: organize imports + format
    python = { "ruff_organize_imports", "ruff_format" },
    rust = { "rustfmt" },
    go = { "goimports" },
    sh = { "shfmt" },
    cpp = { "clang-format" },
    c = { "clang-format" },
  },

  format_on_save = {
    timeout_ms = 2000,
    lsp_format = "fallback",
  },
}

return options

