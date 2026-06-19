-- Treesitter: syntax highlighting, indentation, and textobject selection/movement.
return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "vim", "lua", "vimdoc", "html", "css",
        "javascript", "typescript", "tsx", "json", "yaml",
        "markdown", "markdown_inline", "bash", "python",
        "rust", "go", "cpp", "c", "dockerfile",
        "git_config", "gitignore", "kotlin", "java", "xml",
      },
      highlight = { enable = true },
      indent = { enable = true },
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
            ["ai"] = "@conditional.outer",
            ["ii"] = "@conditional.inner",
            ["al"] = "@loop.outer",
            ["il"] = "@loop.inner",
            ["ab"] = "@block.outer",
            ["ib"] = "@block.inner",
            ["aa"] = "@parameter.outer",
            ["ia"] = "@parameter.inner",
          },
        },
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start     = { ["]m"] = "@function.outer", ["]]"] = "@class.outer" },
          goto_next_end       = { ["]M"] = "@function.outer", ["]["] = "@class.outer" },
          goto_previous_start = { ["[m"] = "@function.outer", ["[["] = "@class.outer" },
          goto_previous_end   = { ["[M"] = "@function.outer", ["[]"] = "@class.outer" },
        },
      },
    })
  end,
}
