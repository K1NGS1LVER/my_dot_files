-- Active theme: "sora" | "cendre"
local theme = "cendre"

local themes = {
	sora = {
		black = 0xff0e1018,
		white = 0xffc8d0e0,
		red = 0xffc46c78,
		green = 0xff90c8a0,
		blue = 0xff80c8e0,
		yellow = 0xffd4b878,
		orange = 0xffd0a888,
		magenta = 0xffb0a0d8,
		grey = 0xff586478,
		shadow = 0xff0a0c12,

		-- accent set (exposed as colors.sora.*)
		accent = {
			cyan = 0xff80c8e0,
			purple = 0xffb0a0d8,
			sage = 0xff90c8a0,
			rose = 0xffd0909c,
			gold = 0xffd4b878,
			peach = 0xffd0a888,
			teal = 0xff78b8b0,
			steel = 0xff8898b8,
			-- the bar's own accent: apple, clock, active space, default icon
			primary = 0xff80c8e0,
		},

		-- status, not syntax: thresholds and failures only. warn must not be
		-- gold, the cran below it in the cpu/ram ramp.
		semantic = {
			error = 0xffc46c78,
			warn = 0xffd0a888,
			ok = 0xff90c8a0,
			info = 0xff80c8e0,
		},

		highlight = 0xff8898b8,
		bar = { bg = 0xcc0e1018, border = 0xff222838 },
		popup = { bg = 0xc014161e, border = 0xff586478 },
		bg1 = 0xff1e2430,
		bg2 = 0xff222838,
	},

	-- Cendre (hard) -- canonical palette from lua/cendre/palette.lua
	cendre = {
		black = 0xff090909,
		white = 0xfff2f2f2,
		red = 0xffb8b8b8,
		green = 0xffd0d0d0,
		blue = 0xffa8a8a8,
		yellow = 0xffdedede,
		orange = 0xffc4c4c4,
		magenta = 0xffb0b0b0,
		grey = 0xff737373,
		shadow = 0xff050505,

		-- The five pigments, under the accent names this config already uses.
		-- cyan was 0xff58bdff, which is semantic.info: a diagnostic worn as an
		-- everyday accent. frost is the palette's only cool pigment.
		accent = {
			cyan = 0xffd8d8d8,
			purple = 0xffb8b8b8,
			sage = 0xffc8c8c8,
			rose = 0xffb0b0b0,
			gold = 0xffe0e0e0,
			peach = 0xffc0c0c0,
			teal = 0xffa8a8a8,
			steel = 0xffd0d0d0,
			primary = 0xffeeeeee,
		},

		-- Diagnostics carry more chroma than any pigment, on purpose, so a
		-- failing widget never wears the same red as a keyword.
		semantic = {
			error = 0xffa8a8a8,
			warn = 0xffd0d0d0,
			ok = 0xffc0c0c0,
			info = 0xffe0e0e0,
		},

		highlight = 0xfff2f2f2,
		bar = { bg = 0xcc090909, border = 0xff303030 },
		popup = { bg = 0xc0050505, border = 0xff505050 },
		bg1 = 0xff1c1c1c,
		bg2 = 0xff2b2b2b,
	},
}

-- themes not defined here (e.g. kintsugi-flared, set by bin/theme) fall back
-- to cendre rather than indexing nil and taking the whole bar down.
local t = themes[theme] or themes.cendre

return {
	black = t.black,
	white = t.white,
	red = t.red,
	green = t.green,
	blue = t.blue,
	yellow = t.yellow,
	orange = t.orange,
	magenta = t.magenta,
	grey = t.grey,
	shadow = t.shadow,
	transparent = 0x00000000,

	sora = t.accent,
	semantic = t.semantic,
	highlight = t.highlight,
	bar = t.bar,
	popup = t.popup,
	bg1 = t.bg1,
	bg2 = t.bg2,

	with_alpha = function(color, alpha)
		if alpha > 1.0 or alpha < 0.0 then
			return color
		end
		return (color & 0x00ffffff) | (math.floor(alpha * 255.0) << 24)
	end,
}
