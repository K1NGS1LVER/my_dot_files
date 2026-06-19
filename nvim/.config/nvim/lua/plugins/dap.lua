-- Debug Adapter Protocol: breakpoints, stepping, REPL, virtual text.
-- Go debugger adapter included via nvim-dap-go.
return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
    "theHamsta/nvim-dap-virtual-text",
    "leoluz/nvim-dap-go",
  },
  keys = {
    { "<leader>db", "<cmd>DapToggleBreakpoint<cr>", desc = "Toggle breakpoint" },
    { "<leader>dc", "<cmd>DapContinue<cr>",         desc = "Continue" },
    { "<leader>di", "<cmd>DapStepInto<cr>",          desc = "Step into" },
    { "<leader>do", "<cmd>DapStepOver<cr>",          desc = "Step over" },
    { "<leader>dO", "<cmd>DapStepOut<cr>",           desc = "Step out" },
    { "<leader>dr", "<cmd>DapToggleRepl<cr>",        desc = "Toggle REPL" },
    { "<leader>dgt", function() require("dap-go").debug_test() end, desc = "Debug Go Test" },
    { "<leader>du", function() require("dapui").toggle() end,       desc = "Toggle DAP UI" },
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    require("dap-go").setup()
    dapui.setup()
    require("nvim-dap-virtual-text").setup()

    -- Auto-open/close DAP UI on debug session lifecycle
    dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
    dap.listeners.before.event_terminated["dapui_config"]  = function() dapui.close() end
    dap.listeners.before.event_exited["dapui_config"]      = function() dapui.close() end
  end,
}
