-- Obsidian vault integration. Only activates for markdown files in ~/notes/.
-- UI rendering is handled by render-markdown.nvim; this provides linking/search.
return {
  "epwalsh/obsidian.nvim",
  version = "*",
  event = {
    "BufReadPre " .. vim.fn.expand("~") .. "/notes/*.md",
    "BufNewFile " .. vim.fn.expand("~") .. "/notes/*.md",
  },
  cmd = { "Obsidian", "ObsidianQuickSwitch", "ObsidianNew", "ObsidianSearch" },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
  },
  opts = {
    workspaces = { { name = "notes", path = "~/notes" } },
    ui = { enable = false },
    completion = { nvim_cmp = true, min_chars = 2 },
    note_id_func = function(title) return title end,
    follow_url_func = function(url) vim.fn.jobstart({ "open", url }) end,
  },
}
