-- Treesitter: syntax highlighting, indentation, and textobject selection/movement.
--
-- On the `main` branch (not `master`, which is frozen upstream and only
-- officially supports Neovim up to 0.12 with no further fixes). This repo
-- targets whatever Neovim ships from Homebrew, so `main` is the branch that
-- actually gets bug fixes going forward. Highlighting/indent are enabled via
-- core Neovim APIs here, not the old nvim-treesitter.configs module, which
-- no longer exists on `main`.
local ensure_installed = {
  "vim", "lua", "vimdoc", "html", "css",
  "javascript", "typescript", "tsx", "json", "yaml",
  "markdown", "markdown_inline", "bash", "python",
  "rust", "go", "cpp", "c", "dockerfile",
  "git_config", "gitignore", "kotlin", "java", "xml",
}

return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").install(ensure_installed)

      local group = vim.api.nvim_create_augroup("UserTreesitter", { clear = true })
      vim.api.nvim_create_autocmd("FileType", {
        group = group,
        callback = function(args)
          if pcall(vim.treesitter.start, args.buf) then
            vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("nvim-treesitter-textobjects").setup {
        select = { lookahead = true },
        move = { set_jumps = true },
      }

      local select = require "nvim-treesitter-textobjects.select"
      local select_map = {
        ["af"] = "@function.outer", ["if"] = "@function.inner",
        ["ac"] = "@class.outer", ["ic"] = "@class.inner",
        ["ai"] = "@conditional.outer", ["ii"] = "@conditional.inner",
        ["al"] = "@loop.outer", ["il"] = "@loop.inner",
        ["ab"] = "@block.outer", ["ib"] = "@block.inner",
        ["aa"] = "@parameter.outer", ["ia"] = "@parameter.inner",
      }
      for key, query in pairs(select_map) do
        vim.keymap.set({ "x", "o" }, key, function()
          select.select_textobject(query, "textobjects")
        end)
      end

      local move = require "nvim-treesitter-textobjects.move"
      vim.keymap.set({ "n", "x", "o" }, "]m", function() move.goto_next_start("@function.outer", "textobjects") end)
      vim.keymap.set({ "n", "x", "o" }, "]]", function() move.goto_next_start("@class.outer", "textobjects") end)
      vim.keymap.set({ "n", "x", "o" }, "]M", function() move.goto_next_end("@function.outer", "textobjects") end)
      vim.keymap.set({ "n", "x", "o" }, "][", function() move.goto_next_end("@class.outer", "textobjects") end)
      vim.keymap.set({ "n", "x", "o" }, "[m", function() move.goto_previous_start("@function.outer", "textobjects") end)
      vim.keymap.set({ "n", "x", "o" }, "[[", function() move.goto_previous_start("@class.outer", "textobjects") end)
      vim.keymap.set({ "n", "x", "o" }, "[M", function() move.goto_previous_end("@function.outer", "textobjects") end)
      vim.keymap.set({ "n", "x", "o" }, "[]", function() move.goto_previous_end("@class.outer", "textobjects") end)
    end,
  },
}
