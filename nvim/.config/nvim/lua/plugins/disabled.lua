-- Explicitly disable plugins shipped by NvChad core that are replaced
-- by our stack (yazi replaces nvim-tree).
return {
  { "nvim-tree/nvim-tree.lua", enabled = false },
}
