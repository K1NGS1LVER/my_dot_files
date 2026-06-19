-- REST client (Postman alternative). Activated on .http file open.
return {
  "mistweaverco/kulala.nvim",
  ft = { "http", "rest" },
  keys = {
    { "<leader>rr", function() require("kulala").run() end,         desc = "Run Kulala" },
    { "<leader>R",  "",                                              desc = "+REST Client" },
    { "<leader>Rs", "<cmd>lua require('kulala').run()<cr>",          desc = "Send request" },
    { "<leader>Ra", "<cmd>lua require('kulala').run_all()<cr>",      desc = "Send all requests" },
    { "<leader>Rt", "<cmd>lua require('kulala').toggle_view()<cr>",  desc = "Toggle headers/body" },
    { "<leader>Rp", "<cmd>lua require('kulala').jump_prev()<cr>",    desc = "Previous request" },
    { "<leader>Rn", "<cmd>lua require('kulala').jump_next()<cr>",    desc = "Next request" },
    { "<leader>Ri", "<cmd>lua require('kulala').inspect()<cr>",      desc = "Inspect request" },
    { "<leader>Rc", "<cmd>lua require('kulala').copy()<cr>",         desc = "Copy as cURL" },
    { "<leader>Rq", "<cmd>lua require('kulala').close()<cr>",        desc = "Close window" },
  },
  opts = {},
}
