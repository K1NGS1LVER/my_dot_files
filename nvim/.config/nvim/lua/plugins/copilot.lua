-- GitHub Copilot: inline suggestions + chat interface.
-- Suggestion accepted via C-l (avoids Tab conflict with nvim-cmp).
-- CopilotChat on canary branch — monitor for stability.
return {
  -- Inline suggestion engine
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = {
          enabled = true,
          auto_trigger = true,
          debounce = 75,
          keymap = {
            accept = "<C-l>",
            accept_word = false,
            accept_line = false,
            next = "<M-]>",
            prev = "<M-[>",
            dismiss = "<C-]>",
          },
        },
        panel = { enabled = false },
      })
    end,
  },

  -- Chat interface
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    dependencies = {
      { "zbirenbaum/copilot.lua" },
      { "nvim-lua/plenary.nvim" },
    },
    build = "make tiktoken",
    opts = { debug = false },
    keys = {
      { "<leader>cc",  "<cmd>CopilotChatToggle<cr>",   desc = "Copilot Chat Toggle" },
      { "<leader>cce", "<cmd>CopilotChatExplain<cr>",  desc = "Copilot Explain" },
      { "<leader>ccf", "<cmd>CopilotChatFix<cr>",      desc = "Copilot Fix" },
      { "<leader>cco", "<cmd>CopilotChatOptimize<cr>", desc = "Copilot Optimize" },
      { "<leader>ccd", "<cmd>CopilotChatDocs<cr>",     desc = "Copilot Docs" },
      { "<leader>cct", "<cmd>CopilotChatTests<cr>",    desc = "Copilot Tests" },
    },
  },
}
