require "nvchad.mappings"

local map = vim.keymap.set

-- Better command mode
map("n", ";", function()
  local next_char = vim.fn.getcharstr()
  if next_char:match "%d" then
    vim.api.nvim_feedkeys(next_char, "n", false)
  else
    vim.api.nvim_feedkeys(":" .. next_char, "n", false)
  end
end, { desc = "Smart ; key" })
map("i", "jk", "<ESC>", { desc = "Exit insert mode" })

-- Save and quit
map({ "n", "v" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save file" })
map("n", "<leader>qq", "<cmd>q<cr>", { desc = "Quit" })
map("n", "<leader>Q", "<cmd>qa!<cr>", { desc = "Quit all without saving" })

-- Better navigation
map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center" })
map("n", "n", "nzzzv", { desc = "Next search result and center" })
map("n", "N", "Nzzzv", { desc = "Previous search result and center" })

-- Smart window navigation (Multiplexer aware)
local function move_focus(dir)
  local win = vim.api.nvim_get_current_win()

  -- Try moving within Neovim first
  if dir == "h" or dir == "left"  then vim.cmd("TmuxNavigateLeft")
  elseif dir == "j" or dir == "down"  then vim.cmd("TmuxNavigateDown")
  elseif dir == "k" or dir == "up"    then vim.cmd("TmuxNavigateUp")
  elseif dir == "l" or dir == "right" then vim.cmd("TmuxNavigateRight")
  end

  -- If the window didn't change, try moving the multiplexer (Zellij or Kitty)
  if win == vim.api.nvim_get_current_win() then
    local multiplexer_dir = { 
      h = "left", j = "down", k = "up", l = "right",
      left = "left", down = "down", up = "up", right = "right"
    }

    if os.getenv("ZELLIJ") then
      vim.fn.system("zellij action move-focus " .. multiplexer_dir[dir])
    elseif os.getenv("KITTY_PID") then
      -- Uses kitty's remote control to focus the neighboring window
      vim.fn.system("kitty @ --to unix:/tmp/mykitty focus-window --match neighboring:" .. multiplexer_dir[dir])
    end
  end
end

-- Keymaps for navigation
map("n", "<C-Left>",  function() move_focus("left")  end, { desc = "Window left" })
map("n", "<C-Down>",  function() move_focus("down")  end, { desc = "Window down" })
map("n", "<C-Up>",    function() move_focus("up")    end, { desc = "Window up" })
map("n", "<C-Right>", function() move_focus("right") end, { desc = "Window right" })

-- Standardized 'Close' (Universal X)
map("n", "<leader>x", "<cmd>bd<cr>", { desc = "Close Buffer" })
map("n", "<leader>X", "<cmd>q<cr>", { desc = "Close Window" })

-- Resize windows (Moved to Ctrl + Shift + Arrows)
map("n", "<C-S-Up>",    "<cmd>resize +2<cr>",          { desc = "Increase window height" })
map("n", "<C-S-Down>",  "<cmd>resize -2<cr>",          { desc = "Decrease window height" })
map("n", "<C-S-Left>",  "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<C-S-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Better indenting
map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })

-- Move lines
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move line down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move line up" })
map("n", "<A-Down>", "<cmd>m .+1<cr>==", { desc = "Move line down" })
map("n", "<A-Up>", "<cmd>m .-2<cr>==", { desc = "Move line up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move selection down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move selection up" })
map("v", "<A-Down>", ":m '>+1<cr>gv=gv", { desc = "Move selection down" })
map("v", "<A-Up>", ":m '<-2<cr>gv=gv", { desc = "Move selection up" })

-- Better paste
map("v", "p", '"_dP', { desc = "Paste without yanking" })

-- Clear search highlight
map("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "Clear search highlight" })

-- Buffer navigation
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Previous buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "<leader>bd", "<cmd>bd<cr>", { desc = "Delete buffer" })

-- delete wihout copying to the clipboard buffer uses the black hole register
map("n", "<leader>dd", '"_dd', { desc = "delete without copying" })

-- LSP mappings (enhanced)
map("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
map("n", "gr", vim.lsp.buf.references, { desc = "References" })
map("n", "gI", vim.lsp.buf.implementation, { desc = "Go to implementation" })
map("n", "gy", vim.lsp.buf.type_definition, { desc = "Go to type definition" })
map("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
map("n", "K", vim.lsp.buf.hover, { desc = "Hover documentation" })
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename" })
map("n", "<leader>lf", vim.lsp.buf.format, { desc = "Format" })

-- Diagnostic mappings
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
map("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show diagnostic" })

-- Theme Switcher (Telescope)
map("n", "<leader>th", "<cmd>Telescope colorscheme enable_preview=true<cr>", { desc = "Theme Switcher" })

-- Telescope file navigation
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
map("n", "<leader>fw", "<cmd>Telescope live_grep<cr>", { desc = "Live grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help tags" })
map("n", "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<cr>", { desc = "Find in current buffer" })
map("n", "<leader>fo", "<cmd>Telescope oldfiles<cr>", { desc = "Find recent files" })

map("n", "<leader>tt", function()
  vim.g.transparency_enabled = not vim.g.transparency_enabled
  -- Reload current colorscheme to re-trigger the autocmd
  vim.cmd("colorscheme " .. vim.g.colors_name)
  print("Transparency: " .. tostring(vim.g.transparency_enabled))
end, { desc = "Toggle Transparency" })

map("n", "<leader>fn", "<cmd>ObsidianQuickSwitch<cr>", { desc = "Find Obsidian Note" })

-- Terminal Compatibility Mappings (Replaces ToggleTerm)
map({ "n", "t" }, "<C-t>", function()
  require("nvchad.term").toggle { pos = "float", id = "floatTerm" }
end, { desc = "Toggle Floating Terminal" })

map({ "n", "t" }, "<leader>tf", function()
  require("nvchad.term").toggle { pos = "float", id = "floatTerm" }
end, { desc = "Toggle Floating Terminal" })

map({ "n", "t" }, "<leader>h", function()
  require("nvchad.term").toggle { pos = "sp", id = "htoggleTerm" }
end, { desc = "Toggle Horizontal Terminal" })

map({ "n", "t" }, "<leader>v", function()
  require("nvchad.term").toggle { pos = "vsp", id = "vtoggleTerm" }
end, { desc = "Toggle Vertical Terminal" })

-- Close buffer with <leader>x
map("n", "<leader>x", "<cmd>bd<cr>", { desc = "Close Buffer" })
