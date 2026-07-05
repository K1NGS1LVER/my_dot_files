-- Jupyter Notebook (.ipynb) and Markdown editing + execution ecosystem.
return {
  -- GCBallesteros/jupytext.nvim: Automatically convert .ipynb to markdown when opened
  -- and sync back to .ipynb when saved.
  {
    "GCBallesteros/jupytext.nvim",
    lazy = false,
    config = function()
      require("jupytext").setup({
        style = "markdown",
        output_extension = "md",
        force_ft = "markdown",
      })
    end,
  },

  -- 3rd/image.nvim: Render images/graphs directly in the terminal
  {
    "3rd/image.nvim",
    -- kiyoon/magick.nvim vendors a prebuilt ImageMagick binding so image.nvim
    -- doesn't need luarocks (disabled in configs/lazy.lua: rocks.enabled =
    -- false). Do not "fix" that by re-enabling luarocks; imagemagick itself
    -- still comes from the Brewfile (`brew "imagemagick"`) for the `magick`
    -- CLI molten/other tooling shells out to.
    dependencies = {
      "kiyoon/magick.nvim",
    },
    opts = {
      backend = "kitty", -- Kitty/Ghostty compatible backend
      -- "unicode-placeholders" renders images through the normal text grid
      -- instead of absolute cursor positioning, which is the reliable method
      -- under tmux (placements scroll/clip with the pane instead of floating
      -- over the whole terminal). The default "normal" method also works once
      -- the get_tty() fix in config below is in place, but placeholders
      -- behave better in this tmux-centric setup.
      kitty_method = "unicode-placeholders",
      integrations = {
        markdown = {
          enabled = true,
          clear_in_insert_mode = false,
          download_remote_images = true,
          only_render_image_at_cursor = false,
          filetypes = { "markdown", "vimwiki", "quarto" },
        },
        -- image.nvim's built-in "markdown" integration only recognizes
        -- native ![alt](url) syntax, not raw HTML <img> tags (the common
        -- <p align="center"><img ...></p> README pattern). This custom
        -- integration (lua/image/integrations/markdown_html.lua) covers
        -- that case; see its comments for why it's a separate module.
        markdown_html = {
          enabled = true,
          clear_in_insert_mode = false,
          download_remote_images = true,
          only_render_image_at_cursor = false,
          filetypes = { "markdown", "vimwiki", "quarto" },
        },
      },
      max_width = 100,
      max_height = 12,
      max_width_window_percentage = math.huge,
      max_height_window_percentage = math.huge,
      -- When true, the renderer silently bails out ("overlap" mask) whenever
      -- ANY other window is open, not just ones actually covering the image,
      -- so images never render in a normal multi-split layout.
      window_overlap_clear_enabled = false,
      window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
    },
    config = function(_, opts)
      -- Neovim 0.11+ runs plugin Lua inside an `nvim --embed` server process
      -- whose io.popen children get pipes (not the pty) as stdio, so
      -- image.nvim's get_tty() (io.popen("tty")) returns the literal string
      -- "not a tty". Under tmux, that garbage value makes the kitty backend's
      -- get_clear_tty_override() think nvim's tty differs from the pane tty,
      -- so every clear/delete is written RAW (no tmux passthrough wrapper)
      -- to the pane tty. tmux forwards those through its buffered pane-output
      -- path, so the delete-all reaches Ghostty AFTER the passthrough-wrapped
      -- renders it preceded in code and wipes them out: images "render
      -- successfully" per the plugin's own state, but are never visible.
      -- The server's own fd 1 IS the pty, so resolve its name via libc
      -- ttyname(3) instead of a subprocess. Must run before require("image")
      -- .setup() because the kitty backend captures editor_tty at require
      -- time.
      local term = require("image/utils/term")
      local original_get_tty = term.get_tty
      term.get_tty = function()
        local ok, tty = pcall(function()
          local ffi = require("ffi")
          pcall(ffi.cdef, "char *ttyname(int fd);")
          local name = ffi.C.ttyname(1)
          return name ~= nil and ffi.string(name) or nil
        end)
        if ok and tty and tty:sub(1, 1) == "/" then return tty end
        local fallback = original_get_tty()
        if fallback and fallback:sub(1, 1) == "/" then return fallback end
        return nil
      end
      require("image").setup(opts)
    end,
  },

  -- benlubas/molten-nvim: Code execution, kernel management, and inline outputs
  {
    "benlubas/molten-nvim",
    version = "^1.0.0",
    build = ":UpdateRemotePlugins",
    lazy = false,
    init = function()
      -- Configure Molten behavior
      vim.g.molten_image_provider = "image.nvim"
      vim.g.molten_auto_open_output = true
      vim.g.molten_wrap_output = true
      vim.g.molten_virt_text_output = true
      vim.g.molten_virt_lines_off_by_1 = true
      vim.g.molten_output_show_more = true

      -- Keymaps for Molten execution & outputs
      vim.keymap.set("n", "<leader>mi", ":MoltenInit<CR>", { silent = true, desc = "Initialize Kernel" })
      vim.keymap.set("n", "<leader>me", ":set operatorfunc=MoltenOperatorfunc<CR>g@", { silent = true, desc = "Run operator" })
      vim.keymap.set("n", "<leader>mo", ":MoltenEvaluateLine<CR>", { silent = true, desc = "Run line" })
      vim.keymap.set("v", "<leader>me", ":<C-u>MoltenEvaluateVisual<CR>gv", { silent = true, desc = "Run visual selection" })
      vim.keymap.set("n", "<leader>mr", ":MoltenReevaluateCell<CR>", { silent = true, desc = "Re-evaluate cell" })
      vim.keymap.set("n", "<leader>md", ":MoltenDelete<CR>", { silent = true, desc = "Delete output" })
      vim.keymap.set("n", "<leader>ms", ":MoltenShowOutput<CR>", { silent = true, desc = "Show output window" })
      vim.keymap.set("n", "<leader>mh", ":MoltenHideOutput<CR>", { silent = true, desc = "Hide output window" })
      vim.keymap.set("n", "<leader>mx", ":MoltenInterrupt<CR>", { silent = true, desc = "Interrupt kernel" })
    end,
  },

  -- jmbuhr/otter.nvim: LSP completion and hover for code blocks inside markdown
  {
    "jmbuhr/otter.nvim",
    ft = { "markdown", "quarto" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("otter").setup({
        buffers = {
          set_filetype = true,
          write_to_disk = true,
        },
      })
      -- Activate otter on markdown/quarto buffers after plugin is loaded
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "markdown", "quarto" },
        callback = function()
          require("otter").activate({ "python", "lua" })
        end,
      })
    end,
  },

  -- quarto-dev/quarto-nvim: Integrates Otter, Molten, and adds cell running support
  {
    "quarto-dev/quarto-nvim",
    dependencies = {
      "jmbuhr/otter.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      lspFeatures = {
        enabled = true,
        languages = { "python", "lua" },
        chunks = "all",
      },
      codeRunner = {
        enabled = true,
        default_method = "molten",
      },
    },
    init = function()
      -- Keymaps for Quarto runner
      vim.keymap.set("n", "<leader>rc", function()
        require("quarto.runner").run_cell()
      end, { desc = "Run Cell", silent = true })
      vim.keymap.set("n", "<leader>ra", function()
        require("quarto.runner").run_above()
      end, { desc = "Run Cell & Above", silent = true })
      vim.keymap.set("n", "<leader>rA", function()
        require("quarto.runner").run_all()
      end, { desc = "Run All Cells", silent = true })
      vim.keymap.set("n", "<leader>rl", function()
        require("quarto.runner").run_line()
      end, { desc = "Run Line", silent = true })
      vim.keymap.set("v", "<leader>r", function()
        require("quarto.runner").run_range()
      end, { desc = "Run Range", silent = true })

      -- Jump between code cell blocks
      vim.keymap.set("n", "]x", function()
        vim.fn.search("^```")
      end, { desc = "Jump to next cell" })
      vim.keymap.set("n", "[x", function()
        vim.fn.search("^```", "b")
      end, { desc = "Jump to previous cell" })
    end,
  },
}
