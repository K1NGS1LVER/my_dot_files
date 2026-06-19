-- Indent guides. IBL highlight groups are pre-defined in init() to prevent
-- race conditions when switching colorschemes.
return {
  "lukas-reineke/indent-blankline.nvim",
  event = "User FilePost",
  main = "ibl",
  init = function()
    -- Pre-define IBL highlights before plugin loads to prevent theme-switch crashes
    local groups = { "IblChar", "IblWhitespace", "IblIndent", "IblScope", "IblScopeChar", "IblScopeIndent" }
    for _, group in ipairs(groups) do
      vim.api.nvim_set_hl(0, group, { link = "Whitespace", default = true })
    end
  end,
  opts = {
    indent = { char = "│" },
    scope = { enabled = false },
  },
}
