local cmp = require "cmp"

require("cmp_nvim_lsp")
require("cmp_buffer")
require("cmp_path")
require("cmp_luasnip")

local options = {
  completion = {
    throttle_time = 100, -- Don't trigger completion too often
    debounce_time = 100, -- Debounce completion requests
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = {
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-k>"] = cmp.mapping.complete(), -- Fallback trigger key
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ["<C-l>"] = cmp.mapping(function(fallback)
      if require("copilot.suggestion").is_visible() then
        require("copilot.suggestion").accept()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if require("copilot.suggestion").is_visible() then
        require("copilot.suggestion").accept()
      elseif cmp.visible() then
        cmp.select_next_item()
      elseif require("luasnip").expand_or_jumpable() then
        require("luasnip").expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif require("luasnip").jumpable(-1) then
        require("luasnip").jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  },
  -- GLOBAL SOURCES
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer", option = { max_file_size = 1024 * 1024 } }, -- Ignore files over 1MB
    { name = "path" },
  },
}

-- Apply the global setup
cmp.setup(options)

-- AUTOCOMMAND for Robust Markdown Setup
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    require("cmp").setup.buffer({
      sources = require("cmp").config.sources({
        { name = "obsidian" },
        { name = "obsidian_new" },
        { name = "luasnip" },
        { name = "buffer", option = { max_file_size = 1024 * 1024 } }, -- Ignore files over 1MB
        { name = "path" },
      }),
    })
  end,
})