if vim.g.neovide then
  -- Window Settings
  vim.g.neovide_fullscreen = false
  vim.g.neovide_remember_window_size = true

  -- Font Settings
  vim.o.guifont = "JetBrainsMono Nerd Font:h18"

  -- Animation Settings
  vim.g.neovide_cursor_animation_length = 0.13
  vim.g.neovide_cursor_trail_size = 0.8
  vim.g.neovide_scroll_animation_length = 0.3

  -- Transparency
  vim.g.neovide_opacity = 0.95
  vim.g.neovide_floating_blur_amount_x = 2.0
  vim.g.neovide_floating_blur_amount_y = 2.0
  
  -- Force Theme Load
  vim.o.background = "dark"
  vim.o.termguicolors = true
  
  -- Helper function to toggle maximize
  vim.keymap.set("n", "<F11>", function()
    vim.g.neovide_fullscreen = not vim.g.neovide_fullscreen
  end, { desc = "Toggle Fullscreen" })
end