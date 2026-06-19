-- Telescope FZF native sorter. Telescope core is provided by NvChad.
-- Builds a C library for O(n) fuzzy matching instead of Lua fallback.
return {
  "nvim-telescope/telescope-fzf-native.nvim",
  build = "make",
  config = function()
    require("telescope").load_extension("fzf")
  end,
}
