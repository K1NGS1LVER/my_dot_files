if vim.g.neovide then
  -- Window Settings
  vim.g.neovide_fullscreen = false
  vim.g.neovide_remember_window_size = true

  -- Font Settings (Use the one we just installed)
  vim.o.guifont = "GeistMono Nerd Font:h20"

  -- Animation Settings (The "Smooth" feel)
  vim.g.neovide_cursor_animation_length = 0.13
  vim.g.neovide_cursor_trail_size = 0.8
  vim.g.neovide_scroll_animation_length = 0.3

  -- Transparency (Optional, matches Ghostty vibe)
  vim.g.neovide_transparency = 0.95
  vim.g.neovide_floating_blur_amount_x = 2.0
  vim.g.neovide_floating_blur_amount_y = 2.0

  -- Helper function to toggle maximize
  vim.keymap.set("n", "<F11>", function()
    vim.g.neovide_fullscreen = not vim.g.neovide_fullscreen
  end, { desc = "Toggle Fullscreen" })

  -- Maximize on startup (using a dirty hack because pure fullscreen is sometimes annoying)
  -- or we can just set initial dimensions really big
end
