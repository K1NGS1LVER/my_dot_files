local colors = require("colors")

-- Equivalent to the --bar domain
sbar.bar({
	topmost = "window",
	height = 40,
	color = colors.transparent,
	-- color = colors.bar.bg,
	padding_right = 0,
	padding_left = 0,
	corner_radius = 9,
	-- Leave room for the macOS menu-bar area above AeroSpace windows.
	-- left/right_padding (27) minus the 8 an item adds before its glyph
	-- (padding_left 5 + icon padding 3)
	-- margin = 19,
	margin = 8,
	sticky = "on",
	y_offset = 2,
	shadow = true,
	blur_radius = 0,
	-- border_width = 3,
	-- border_color = colors.gruv.cream,
})
