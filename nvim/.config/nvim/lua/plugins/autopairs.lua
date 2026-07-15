-- Auto-close brackets, quotes, etc. Disabled for [ in markdown to avoid
-- conflicting with Obsidian's [[wikilink]] syntax.
return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  config = function()
    local npairs = require("nvim-autopairs")
    npairs.setup({
      disable_filetype = { "TelescopePrompt", "spectre_panel" },
      -- map_cr defaults to true: autopairs claims <CR> itself (for
      -- bracket-pair-aware newline expansion), re-applied on every
      -- InsertEnter. That's a documented conflict with autolist.nvim's own
      -- <CR> mapping (github.com/gaoDean/autolist.nvim/issues/43) - it was
      -- silently reclaiming <CR> in markdown buffers after the first insert
      -- session, which is what caused Enter-after-list-item to behave
      -- unpredictably instead of continuing the bullet.
      map_cr = false,
    })

    local cond = require("nvim-autopairs.conds")
    npairs.get_rule("["):with_pair(cond.not_filetypes({ "markdown" }))
  end,
}
