vim.loader.enable()
vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

-- Bootstrap lazy.nvim (stable branch pinned)
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- Load NvChad core + all per-plugin specs from lua/plugins/*.lua
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },
  { import = "plugins" },
}, lazy_config)

-- base46's cache is only recompiled when the plugin is (re)installed, or
-- when something explicitly asks for it: chadrc.lua changing (via
-- scripts/switch-theme rewriting active-theme.lua) does NOT by itself
-- trigger a recompile. Detect a theme change against a stamp file and
-- force a full recompile before anything reads the cache, so switching
-- themes actually takes visual effect on the next nvim launch.
do
  local theme_stamp = vim.g.base46_cache .. ".compiled-theme"
  local ok_chadrc, chadrc = pcall(require, "chadrc")
  local desired_theme = ok_chadrc and chadrc.base46 and chadrc.base46.theme or nil

  if desired_theme then
    local last_theme = nil
    local f = io.open(theme_stamp, "r")
    if f then
      last_theme = f:read "l"
      f:close()
    end

    if desired_theme ~= last_theme then
      local ok_base46, base46 = pcall(require, "base46")
      if ok_base46 and pcall(base46.load_all_highlights) then
        local out = io.open(theme_stamp, "w")
        if out then
          out:write(desired_theme)
          out:close()
        end
      end
    end
  end
end

-- Load base46 theme cache, self-healing if it's missing or stale
-- (e.g. after `rm -rf` on nvim's data dir, or a base46/theme version bump).
local function load_base46_cache(name)
  local path = vim.g.base46_cache .. name
  if not pcall(dofile, path) then
    local ok, base46 = pcall(require, "base46")
    if ok then
      pcall(base46.load_all_highlights)
    end
    if not pcall(dofile, path) then
      vim.schedule(function()
        vim.notify(
          "Failed to load base46 cache '" .. name .. "' even after regenerating. Run :Lazy build base46.",
          vim.log.levels.ERROR,
          { title = "nvim" }
        )
      end)
    end
  end
end

load_base46_cache "defaults"
load_base46_cache "statusline"

require "options"
require "autocmds"

vim.schedule(function()
  require "mappings"
end)

-- PDF Viewer (Sioyek) Integration
local SIOYEK_BIN = "/Applications/sioyek.app/Contents/MacOS/sioyek"
vim.api.nvim_create_user_command("Pdf", function(opts)
  if not vim.uv.fs_stat(SIOYEK_BIN) then
    vim.notify("sioyek not found at " .. SIOYEK_BIN, vim.log.levels.ERROR, { title = "Pdf" })
    return
  end
  local filepath = opts.args
  if filepath == "" then
    filepath = vim.fn.expand "%:p"
  end
  vim.fn.jobstart({
    SIOYEK_BIN,
    "--new-window",
    filepath,
  }, { detach = true })
end, { nargs = "?", complete = "file" })

-- Open PDF with default macOS viewer
local PREVIEW_APP = "/System/Applications/Preview.app"
vim.api.nvim_create_user_command("Openpdf", function(opts)
  if not vim.uv.fs_stat(PREVIEW_APP) then
    vim.notify("Preview.app not found at " .. PREVIEW_APP, vim.log.levels.ERROR, { title = "Openpdf" })
    return
  end
  local filepath = opts.args
  if filepath == "" then
    filepath = vim.fn.expand "%:p"
  end
  vim.fn.jobstart({ "open", "-a", PREVIEW_APP, filepath }, { detach = true })
end, { nargs = "?", complete = "file" })

-- GX Fix: prepend https:// to bare domain URLs
local original_open = vim.ui.open
vim.ui.open = function(path)
  if not path:match "^%a+://" and path:match "^[%w%-%.]+%.[a-z]+" then
    path = "https://" .. path
  end
  return original_open(path)
end

require "neovide"
