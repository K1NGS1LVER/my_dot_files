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
      -- copilot.lua only stops its LSP child via a VimLeavePre autocmd, which
      -- never fires when nvim dies non-gracefully (pane/terminal killed,
      -- crash). The orphaned `language-server.js` then survives forever,
      -- reparented to pid 1. Reaping orphans in `config` runs lazily when
      -- copilot is actually loaded, preventing /bin/ps spawning during startup.
      vim.schedule(function()
        local ok, lines = pcall(vim.fn.systemlist, { "/bin/ps", "-eo", "pid,ppid,args" })
        if not ok or vim.v.shell_error ~= 0 then
          return
        end
        for _, line in ipairs(lines) do
          local pid, ppid = line:match("^%s*(%d+)%s+(%d+)")
          if pid and ppid == "1" and line:find("copilot.lua/copilot/js/language-server.js", 1, true) then
            vim.uv.kill(tonumber(pid), "sigterm")
          end
        end
      end)

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
    cmd = {
      "CopilotChat",
      "CopilotChatOpen",
      "CopilotChatClose",
      "CopilotChatToggle",
      "CopilotChatStop",
      "CopilotChatReset",
      "CopilotChatExplain",
      "CopilotChatReview",
      "CopilotChatFix",
      "CopilotChatOptimize",
      "CopilotChatDocs",
      "CopilotChatTests",
      "CopilotChatCommit",
    },
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
