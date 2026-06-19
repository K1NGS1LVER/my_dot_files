-- Auto-close brackets, quotes, etc. Disabled for [ in markdown to avoid
-- conflicting with Obsidian's [[wikilink]] syntax.
return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  config = function()
    local npairs = require("nvim-autopairs")
    npairs.setup({ disable_filetype = { "TelescopePrompt", "spectre_panel" } })

    local cond = require("nvim-autopairs.conds")
    npairs.get_rule("["):with_pair(cond.not_filetypes({ "markdown" }))
  end,
}
