-- diffview.nvim: Git diff viewer with file tree, blame, and history.
-- Usage:
--   <leader>gd  – open working-tree diff (all modified files)
--   <leader>gh  – open file history for current file
--   <leader>gc  – close diffview
--   :DiffviewOpen [git-rev]  – compare any ref, e.g. :DiffviewOpen HEAD~3
return {
  "sindrets/diffview.nvim",
  cmd = {
    "DiffviewOpen",
    "DiffviewClose",
    "DiffviewToggleFiles",
    "DiffviewFocusFiles",
    "DiffviewFileHistory",
    "DiffviewRefresh",
  },
  keys = {
    { "<leader>gd", "<cmd>DiffviewOpen<cr>",          desc = "Diffview: Open working-tree diff" },
    { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "Diffview: File history (current)" },
    { "<leader>gc", "<cmd>DiffviewClose<cr>",         desc = "Diffview: Close" },
  },
  opts = {
    enhanced_diff_hl = true, -- richer hunk highlighting
    view = {
      default = {
        layout = "diff2_horizontal", -- side-by-side
      },
      merge_tool = {
        layout = "diff3_mixed",      -- 3-way layout during git mergetool
        disable_diagnostics = true,
      },
    },
    file_panel = {
      listing_style = "tree",
      win_config = { width = 35 },
    },
  },
}
