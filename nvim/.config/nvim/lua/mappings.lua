require "nvchad.mappings"

local map = vim.keymap.set

-- Better command mode
map("n", ";", function()
  local next_char = vim.fn.getcharstr()
  if next_char:match("%d") then
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

-- Better window navigation
-- map("n", "<C-h>", "<C-w>h", { desc = "Window left" })
-- map("n", "<C-j>", "<C-w>j", { desc = "Window down" })
-- map("n", "<C-k>", "<C-w>k", { desc = "Window up" })
-- map("n", "<C-l>", "<C-w>l", { desc = "Window right" })

-- Resize windows
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Better indenting
map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })

-- Move lines
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move line down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move line up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move selection down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move selection up" })

-- Better paste
map("v", "p", '"_dP', { desc = "Paste without yanking" })

-- Clear search highlight
map("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "Clear search highlight" })

-- Buffer navigation
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Previous buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "<leader>bd", "<cmd>bd<cr>", { desc = "Delete buffer" })

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

map("n", "<leader>tt", function()
  vim.g.transparency_enabled = not vim.g.transparency_enabled
  -- Reload current colorscheme to re-trigger the autocmd
  vim.cmd("colorscheme " .. vim.g.colors_name)
  print("Transparency: " .. tostring(vim.g.transparency_enabled))
end, { desc = "Toggle Transparency" })

map("n", "<leader>fo", "<cmd>ObsidianQuickSwitch<cr>", { desc = "Find Obsidian Note" })

-- Markdown Checkbox Toggle (Replacement for bullets.vim leader+x)
map("n", "<leader>ck", "<cmd>ToggleCheckbox<cr>", { desc = "Toggle Checkbox" })
map("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle File Explorer" })
map("n", "<leader>o", "<cmd>NvimTreeFocus<cr>", { desc = "Focus File Explorer" })

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

-- AI Model Switcher (Llama3 <-> DeepSeek)
map("n", "<leader>am", function()
  local avante = require("avante.config")
  -- Define the two models
  local model_a = "llama3"
  local model_b = "deepseek-coder:1.3b"
  
  -- Check current model (assuming start state is model_a)
  if vim.g.avante_current_model == model_b then
    vim.g.avante_current_model = model_a
  else
    vim.g.avante_current_model = model_b
  end
  
  -- Apply the change
  -- We access the raw config table and update the providers.ollama.model field
  -- Avante usually reads this on each request, so updating the global config table works
  local options = avante.get()
  options.providers.ollama.model = vim.g.avante_current_model
  
  -- Notify user
  print("Switched AI Model to: " .. vim.g.avante_current_model)
end, { desc = "Toggle AI Model (Llama3 / DeepSeek)" })


-- Close buffer with <leader>x
map("n", "<leader>x", "<cmd>bd<cr>", { desc = "Close Buffer" })

