-- Proper markdown list continuation: continues -/1./- [ ] correctly on Enter,
-- exits the list on an empty Enter, never invents a checkbox on its own.
-- Keymaps are buffer-local (set per-buffer via FileType, not in config()
-- directly) so they never leak into non-markdown filetypes - and <Tab>/<S-Tab>
-- check the existing cmp/copilot/luasnip fallback chain first, since a
-- collision there caused real bugs earlier (see configs/cmp_custom.lua).
return {
  "gaoDean/autolist.nvim",
  ft = { "markdown" },
  config = function()
    require("autolist").setup()

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "markdown",
      callback = function(args)
        local opts = { buffer = args.buf }
        local function map(mode, lhs, rhs)
          vim.keymap.set(mode, lhs, rhs, opts)
        end

        map("i", "<Tab>", function()
          if require("copilot.suggestion").is_visible() then
            require("copilot.suggestion").accept()
          elseif require("cmp").visible() then
            require("cmp").select_next_item()
          elseif require("luasnip").expand_or_jumpable() then
            require("luasnip").expand_or_jump()
          else
            vim.cmd("AutolistTab")
          end
        end)
        map("i", "<S-Tab>", function()
          if require("cmp").visible() then
            require("cmp").select_prev_item()
          elseif require("luasnip").jumpable(-1) then
            require("luasnip").jump(-1)
          else
            vim.cmd("AutolistShiftTab")
          end
        end)

        map("i", "<CR>", "<CR><cmd>AutolistNewBullet<CR>")
        map("n", "o", "o<cmd>AutolistNewBullet<CR>")
        map("n", "O", "O<cmd>AutolistNewBulletBefore<CR>")
        map("n", "<CR>", "<cmd>AutolistToggleCheckbox<CR><CR>")
        map("n", "<C-r>", "<cmd>AutolistRecalculate<CR>")
        map("n", ">>", ">><cmd>AutolistRecalculate<CR>")
        map("n", "<<", "<<<cmd>AutolistRecalculate<CR>")
        map("n", "dd", "dd<cmd>AutolistRecalculate<CR>")
        map("v", "d", "d<cmd>AutolistRecalculate<CR>")
      end,
    })
  end,
}
