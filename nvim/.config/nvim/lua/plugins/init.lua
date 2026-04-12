return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- format on save
    cmd = { "Format" },
    config = function()
      local options = require "configs.conform"
      require("conform").setup(options)

      vim.api.nvim_create_user_command("Format", function(args)
        local range = nil
        if args.count ~= -1 then
          local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
          range = {
            start = { args.line1, 0 },
            ["end"] = { args.line2, end_line:len() },
          }
        end
        require("conform").format { async = true, lsp_fallback = true, range = range }
      end, { range = true })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
    },
    config = function()
      require("mason").setup()
      require "configs.lspconfig"
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "vim",
          "lua",
          "vimdoc",
          "html",
          "css",
          "javascript",
          "typescript",
          "tsx",
          "json",
          "yaml",
          "markdown",
          "markdown_inline",
          "bash",
          "python",
          "rust",
          "go",
          "cpp",
          "c",
          "dockerfile",
          "git_config",
          "gitignore",
          "kotlin",
          "java",
          "xml",
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
              ["ai"] = "@conditional.outer", -- Around If/Switch
              ["ii"] = "@conditional.inner", -- Inside If/Switch
              ["al"] = "@loop.outer",        -- Around Loop
              ["il"] = "@loop.inner",        -- Inside Loop
              ["ab"] = "@block.outer",       -- Around Block
              ["ib"] = "@block.inner",       -- Inside Block
              ["aa"] = "@parameter.outer",   -- Around Argument
              ["ia"] = "@parameter.inner",   -- Inside Argument
            },
          },
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              ["]m"] = "@function.outer",
              ["]]"] = "@class.outer",
            },
            goto_next_end = {
              ["]M"] = "@function.outer",
              ["]["] = "@class.outer",
            },
            goto_previous_start = {
              ["[m"] = "@function.outer",
              ["[["] = "@class.outer",
            },
            goto_previous_end = {
              ["[M"] = "@function.outer",
              ["[]"] = "@class.outer",
            },
          },
        },
      })
    end,
  },


  -- Git integration
  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
    },
  },

  -- Better terminal integration
  -- REMOVED: Redundant with NvChad's internal terminal.
  -- Mappings have been migrated to mappings.lua to maintain functionality.
  -- {
  --   "akinsho/toggleterm.nvim",
  --   version = "*",
  --   cmd = { "ToggleTerm", "TermExec" },
  --   keys = {
  --     { "<C-t>", "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" },
  --     { "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", desc = "Terminal float" },
  --     { "<leader>h", function() require("toggleterm.terminal").toggle("horizontal") end, desc = "Toggle horizontal terminal" },
  --     { "<leader>tv", "<cmd>ToggleTerm direction=vertical<cr>", desc = "Terminal vertical" },
  --   },
  --   opts = {
  --     size = function(term)
  --       if term.direction == "horizontal" then
  --         return 15
  --       elseif term.direction == "vertical" then
  --         return vim.o.columns * 0.4
  --       end
  --     end,
  --     open_mapping = [[<C-t>]],
  --     hide_numbers = true,
  --     shade_terminals = true,
  --     start_in_insert = true,
  --     insert_mappings = true,
  --     terminal_mappings = true,
  --     persist_size = true,
  --     direction = "float",
  --     close_on_exit = true,
  --     shell = vim.o.shell,
  --     float_opts = {
  --       border = "curved",
  --       winblend = 0,
  --     },
  --   },
  -- },

  -- Debugging support
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "theHamsta/nvim-dap-virtual-text",
      "leoluz/nvim-dap-go", -- Add Go debugger support
    },
    keys = {
      { "<leader>db", "<cmd>DapToggleBreakpoint<cr>", desc = "Toggle breakpoint" },
      { "<leader>dc", "<cmd>DapContinue<cr>", desc = "Continue" },
      { "<leader>di", "<cmd>DapStepInto<cr>", desc = "Step into" },
      { "<leader>do", "<cmd>DapStepOver<cr>", desc = "Step over" },
      { "<leader>dO", "<cmd>DapStepOut<cr>", desc = "Step out" },
      { "<leader>dr", "<cmd>DapToggleRepl<cr>", desc = "Toggle REPL" },
      { "<leader>dgt", function() require('dap-go').debug_test() end, desc = "Debug Go Test" }, -- Go specific
      {
        "<leader>du",
        function()
          require("dapui").toggle()
        end,
        desc = "Toggle DAP UI",
      },
    },
    config = function()
      local dap = require "dap"
      local dapui = require "dapui"
      
      require("dap-go").setup() -- Setup Go debugger
      dapui.setup()
      require("nvim-dap-virtual-text").setup()

      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
  },

  -- Trouble - better diagnostics
  {
    "folke/trouble.nvim",
    cmd = { "Trouble" },
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer diagnostics" },
      { "<leader>xl", "<cmd>Trouble loclist toggle<cr>", desc = "Location list" },
      { "<leader>xq", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix list" },
    },
    opts = {},
  },

  -- Better code navigation
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    config = function()
      require("telescope").load_extension "fzf"
    end,
  },

  -- Better commenting
  {
    "numToStr/Comment.nvim",
    keys = {
      { "gcc", mode = "n", desc = "Comment toggle current line" },
      { "gc", mode = { "n", "o" }, desc = "Comment toggle linewise" },
      { "gc", mode = "x", desc = "Comment toggle linewise (visual)" },
      { "gbc", mode = "n", desc = "Comment toggle current block" },
      { "gb", mode = { "n", "o" }, desc = "Comment toggle blockwise" },
      { "gb", mode = "x", desc = "Comment toggle blockwise (visual)" },
    },
    config = function()
      require("Comment").setup()
    end,
  },

  -- this is for the readme extension which is render-readme.nvim --
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      { "<leader>rm", "<cmd>RenderMarkdown toggle<cr>", desc = "Toggle Render Markdown" },
    },
    opts = {
        code = {
            sign = false,
            width = "block",
            right_pad = 1,
        },
        heading = {
            sign = false,
            icons = {},
        },
    },
  },

  -- Markdown Table Management
  {
    "dhruvasagar/vim-table-mode",
    ft = { "markdown" },
    init = function()
      -- Optimize for Markdown
      vim.g.table_mode_syntax_check = 0 -- Faster
      vim.g.table_mode_corner = '|'     -- Use standard markdown pipes
    end,
  },

  -- Multiplexer Navigation (Tmux & Zellij)
  {
    "christoomey/vim-tmux-navigator",
    lazy = false, -- Load immediately to ensure Ctrl-hjkl work instantly
  },

  -- Current colorscheme
  { "catppuccin/nvim", name = "catppuccin", lazy = true },

  -- Transparency Control (Force transparency on any theme)
  {
    "xiyaowong/transparent.nvim",
    lazy = false, -- Load immediately to ensure transparency is applied on startup
    opts = {
      extra_groups = {
        "NvimTreeNormal",
        "NvimTreeNormalNC",
        "NvimTreeWinSeparator",
        "NvimTreeEndOfBuffer",
      },
    },
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    event = "User FilePost",
    opts = {
      indent = { char = "│" },
      scope = { enabled = false },
    },
    main = "ibl",
  },

  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      local npairs = require("nvim-autopairs")
      npairs.setup({
        disable_filetype = { "TelescopePrompt", "spectre_panel" },
      })
      -- Disable [ for markdown to fix obsidian conflict
      -- We need to check if the rule exists first to be safe, but setup() usually adds defaults
      local Rule = require("nvim-autopairs.rule")
      local cond = require("nvim-autopairs.conds")
      -- Remove default [ rule if it exists or just modify it? 
      -- Simpler approach: Just ignore [ in markdown
      npairs.get_rule("["):with_pair(cond.not_filetypes({"markdown"}))
    end,
  },
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    opts = {
      plugins = {
        gitsigns = true,
        tmux = { enabled = true }, -- Explicitly enable tmux integration
        kitty = { enabled = false, font = "+4" },
      },
      on_close = function()
        -- Force restore tmux status
        vim.fn.system("tmux set status on")
        -- Restore zoom if it was zoomed
        vim.cmd("silent! !tmux resize-pane -Z") 
      end,
    },
    keys = {
      { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" },
    },
  },
  -- Obsidian (Note linking)
  {
    "epwalsh/obsidian.nvim",
    version = "*",
    -- Only load for markdown files in your notes directory
    event = {
      "BufReadPre " .. vim.fn.expand("~") .. "/notes/*.md",
      "BufNewFile " .. vim.fn.expand("~") .. "/notes/*.md",
    },
    cmd = { "Obsidian", "ObsidianQuickSwitch", "ObsidianNew", "ObsidianSearch" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
    },
    opts = {
      workspaces = {
        {
          name = "notes",
          path = "~/notes",
        },
      },
      -- Disable heavy UI features (handled by render-markdown.nvim)
      ui = { enable = false },
      completion = {
        nvim_cmp = true,
        min_chars = 2, -- Only trigger after 2 chars
      },
      -- Optional: customize how names/IDs are generated
      note_id_func = function(title)
        return title
      end,
      -- Better performance for large vaults
      follow_url_func = function(url)
        vim.fn.jobstart({"open", url})
      end,
    },
  },

  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("alpha").setup(require("configs.alpha"))
    end,
  },

  -- nvim-cmp custom config
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      require "configs.cmp_custom"
    end,
  },

  -- Yazi - Faster and more feature-rich file explorer
  {
    "mikavilpas/yazi.nvim",
    event = "VeryLazy",
    keys = {
      -- Open yazi at the current file
      {
        "<leader>e",
        function()
          require("yazi").yazi()
        end,
        desc = "Open yazi at the current file",
      },
      -- Open yazi at the project root
      {
        "<leader>cw",
        function()
          require("yazi").yazi(nil, vim.fn.getcwd())
        end,
        desc = "Open yazi at the project root",
      },
    },
    opts = {
      -- if you want to open yazi instead of netrw, see below for more info
      open_for_directories = true,
      keymaps = {
        show_help = '<f1>',
      },
    },
  },

  -- [[
  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      view = {
        side = "right",
      },
      git = {
        enable = true,
        ignore = false, -- Show files even if they are gitignored
      },
      filters = {
        dotfiles = false, -- Show hidden files (starting with .)
      },
    },
    config = function(_, opts)
      opts.view = opts.view or {}
      opts.view.side = "right"
      
      -- Custom Mappings
      opts.on_attach = function(bufnr)
        local api = require "nvim-tree.api"
        
        local function opts(desc)
          return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end
        
        -- Default mappings
        api.config.mappings.default_on_attach(bufnr)
        
        -- Custom: "Go In" (Change Root) on 'l' and 'CR' (Enter) for directories
        vim.keymap.set('n', 'l', api.tree.change_root_to_node, opts('CD'))
        vim.keymap.set('n', '<CR>', api.node.open.edit, opts('Open'))
        
        -- Custom: "Go Out" (Up Directory) on 'h'
        vim.keymap.set('n', 'h', api.tree.change_root_to_parent, opts('Up'))
      end
      
      require("nvim-tree").setup(opts)
      
      -- Force NvChad specific UI fix for right-side tree
      -- This tells the tabline to expect the tree on the right
      require("base46").load_all_highlights()
    end,
  },
  -- ]]

  -- Flash (Fast navigation)
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
      labels = "asdfghjklqwertyuiopzxcvbnm",
      search = {
        mode = "fuzzy",
      },
      jump = {
        autojump = true,
      },
      label = {
        uppercase = false,
        after = true,
        before = false,
        style = "overlay", -- Overlay is often easier to read than floating
      },
    },
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
  },

  -- GitHub Copilot
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
            accept = "<C-l>", -- Ctrl-l to accept suggestion (avoids Tab conflict with cmp)
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

  -- Copilot Chat
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    dependencies = {
      { "zbirenbaum/copilot.lua" },
      { "nvim-lua/plenary.nvim" },
    },
    build = "make tiktoken",
    opts = {
      debug = false,
    },
    keys = {
      { "<leader>cc", "<cmd>CopilotChatToggle<cr>", desc = "Copilot Chat Toggle" },
      { "<leader>cce", "<cmd>CopilotChatExplain<cr>", desc = "Copilot Explain" },
      { "<leader>ccf", "<cmd>CopilotChatFix<cr>", desc = "Copilot Fix" },
      { "<leader>cco", "<cmd>CopilotChatOptimize<cr>", desc = "Copilot Optimize" },
      { "<leader>ccd", "<cmd>CopilotChatDocs<cr>", desc = "Copilot Docs" },
      { "<leader>cct", "<cmd>CopilotChatTests<cr>", desc = "Copilot Tests" },
    },
  },

  -- REST Client (Postman Alternative)
  {
    "mistweaverco/kulala.nvim",
    ft = "http",
    keys = {
      { "<leader>R", "", desc = "+REST Client" },
      { "<leader>Rs", "<cmd>lua require('kulala').run()<cr>", desc = "Send request" },
      { "<leader>Ra", "<cmd>lua require('kulala').run_all()<cr>", desc = "Send all requests" },
      { "<leader>Rt", "<cmd>lua require('kulala').toggle_view()<cr>", desc = "Toggle headers/body" },
      { "<leader>Rp", "<cmd>lua require('kulala').jump_prev()<cr>", desc = "Previous request" },
      { "<leader>Rn", "<cmd>lua require('kulala').jump_next()<cr>", desc = "Next request" },
      { "<leader>Ri", "<cmd>lua require('kulala').inspect()<cr>", desc = "Inspect request" },
      { "<leader>Rc", "<cmd>lua require('kulala').copy()<cr>", desc = "Copy as cURL" },
      { "<leader>Rq", "<cmd>lua require('kulala').close()<cr>", desc = "Close window" },
    },
    opts = {},
  },
}
