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
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "kotlin-language-server",
        "jdtls",
        "lemminx", -- XML
        "pyright",
        "gopls",
        "rust-analyzer",
        "typescript-language-server",
        "lua-language-server",
        "html-lsp",
        "css-lsp",
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
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
        "dockerfile",
        "git_config",
        "gitignore",
        "kotlin",
        "java",
        "xml",
      },
      highlight = { enable = true },
      indent = { enable = true },
    },
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

  -- Sessions
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {},
    keys = {
      {
        "<leader>qs",
        function()
          require("persistence").load()
        end,
        desc = "Restore session",
      },
      {
        "<leader>ql",
        function()
          require("persistence").load { last = true }
        end,
        desc = "Restore last session",
      },
      {
        "<leader>qd",
        function()
          require("persistence").stop()
        end,
        desc = "Don't save session",
      },
    },
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

  -- Surround text objects
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup()
    end,
  },

  -- Better quickfix
  {
    "kevinhwang91/nvim-bqf",
    ft = "qf",
  },

  -- Todo comments
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = "BufReadPost",
    keys = {
      { "<leader>ft", "<cmd>TodoTelescope<cr>", desc = "Find todos" },
    },
    opts = {},
  },
  -- Fix for IblChar error on theme switch
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {},
    config = function(_, opts)
      local hooks = require "ibl.hooks"
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        -- Ensure highlighting exists to prevent crash on theme switch
        vim.api.nvim_set_hl(0, "IblChar", { fg = "#565f89" })
        vim.api.nvim_set_hl(0, "IblScopeChar", { fg = "#565f89" })
      end)
      require("ibl").setup(opts)
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

  -- Multiplexer Navigation (Tmux & Zellij)
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
    keys = {
      { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
    config = function()
        -- If in Zellij, override the tmux navigator commands to send Zellij actions
        if os.getenv("ZELLIJ") then
            vim.keymap.set('n', '<C-h>', function() vim.fn.system("zellij action move-focus left") end)
            vim.keymap.set('n', '<C-j>', function() vim.fn.system("zellij action move-focus down") end)
            vim.keymap.set('n', '<C-k>', function() vim.fn.system("zellij action move-focus up") end)
            vim.keymap.set('n', '<C-l>', function() vim.fn.system("zellij action move-focus right") end)
        end
    end,
  },

  -- Popular Themes
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = { transparent = true },
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    opts = {
      transparent_background = true,
    },
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    opts = { transparent = true },
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = false,
    priority = 1000,
    opts = {
      styles = {
        transparency = true,
      },
    },
  },
  {
    "scottmckendry/cyberdream.nvim",
    lazy = false,
    priority = 1000,
    opts = { transparent = true },
  },
  {
    "EdenEast/nightfox.nvim",
    lazy = false,
    priority = 1000,
    opts = { options = { transparent = true } },
  },
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000,
    opts = { transparent_mode = true },
  },

  -- Note taking features
  {
    "dkarter/bullets.vim",
    ft = { "markdown", "text", "gitcommit", "scratch" },
    init = function()
      -- Keep auto-bulleting (Enter key) but disable default leader mappings
      -- so it doesn't conflict with your <leader>ck or other keys.
      vim.g.bullets_mapping_leader = ''
    end,
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
  -- REMOVED: Redundant with render-markdown.nvim
  -- {
  --   "iamcco/markdown-preview.nvim",
  --   cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  --   ft = { "markdown" },
  --   build = function() vim.fn["mkdp#util#install"]() end,
  --   keys = {
  --     { "<leader>mp", "<cmd>MarkdownPreviewToggle<cr>", desc = "Markdown Preview" },
  --   },
  -- },
  -- Harpoon (File navigation)
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local harpoon = require("harpoon")
      harpoon:setup()
    end,
    keys = {
      { "<leader>a", function() require("harpoon"):list():add() end, desc = "Harpoon Add" },
      { "<C-e>", function() local harpoon = require("harpoon"); harpoon.ui:toggle_quick_menu(harpoon:list()) end, desc = "Harpoon Menu" },
      { "<leader>1", function() require("harpoon"):list():select(1) end, desc = "Harpoon Select 1" },
      { "<leader>2", function() require("harpoon"):list():select(2) end, desc = "Harpoon Select 2" },
      { "<leader>3", function() require("harpoon"):list():select(3) end, desc = "Harpoon Select 3" },
      { "<leader>4", function() require("harpoon"):list():select(4) end, desc = "Harpoon Select 4" },
      { "<C-S-P>", function() require("harpoon"):list():prev() end, desc = "Harpoon Prev" },
      { "<C-S-N>", function() require("harpoon"):list():next() end, desc = "Harpoon Next" },
    },
  },

  -- Obsidian (Note linking)
  {
    "epwalsh/obsidian.nvim",
    version = "*",
    event = {
      "BufReadPre *.md",
      "BufNewFile *.md",
      "BufReadPre *.txt",
      "BufNewFile *.txt",
    },
    cmd = { "Obsidian", "ObsidianQuickSwitch" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/cmp-nvim-lsp", -- Assuming these are needed for cmp_obsidian
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
    },
    opts = {
      workspaces = {
        {
          name = "notes",
          path = "~/notes",
        },
      },
      completion = {
        nvim_cmp = true,
        min_chars = 0,
      },
      -- Optional: customize how names/IDs are generated
      note_id_func = function(title)
        return title
      end,
    },
  },

  -- Table Mode
  {
    "dhruvasagar/vim-table-mode",
    ft = "markdown",
    keys = {
      { "<leader>tm", "<cmd>TableModeToggle<cr>", desc = "Toggle table mode" },
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
      require("nvim-tree").setup(opts)
      
      -- Force NvChad specific UI fix for right-side tree
      -- This tells the tabline to expect the tree on the right
      require("base46").load_all_highlights()
    end,
  },

  -- AI - Avante.nvim (Like Cursor for Neovim)
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = false,
    opts = {
      provider = "ollama",
      auto_suggestions_provider = "ollama", 
      
      -- Force keybindings
      mappings = {
        submit = {
            normal = "<C-s>",
            insert = "<C-s>",
        },
      },
      
      providers = {
        ollama = {
          endpoint = "http://127.0.0.1:11434",
          model = "llama3",
          timeout = 30000,
          temperature = 0,
          max_tokens = 4096,
        },
      },
    },
    build = "make",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
      "zbirenbaum/copilot.lua",
      {
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = { insert_mode = true },
            use_absolute_path = true,
          },
        },
      },
      {
        'MeanderingProgrammer/render-markdown.nvim',
        opts = { file_types = { "markdown", "Avante" } },
        ft = { "markdown", "Avante" },
      },
    },
  },

  -- Better Folding (VSCode style)
  {
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
    event = "BufReadPost",
    opts = {
      provider_selector = function()
        return { "treesitter", "indent" }
      end,
    },
    init = function()
      vim.o.foldcolumn = "0" -- Hide fold column to prevent UI conflict
      vim.o.foldlevel = 99 -- Using ufo provider need a large value
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
    end,
  },
}
