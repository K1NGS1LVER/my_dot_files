local colors = require("colors")
local settings = require("settings")

local workspace_names = {
	"1", "2", "3", "4", "5", "6", "7", "8", "9",
	"A", "D", "E", "M", "N", "O", "P", "Q", "R", "S",
	"U", "V", "X", "Y", "Z",
}

local spaces = {}

sbar.add("event", "aerospace_workspace_change")

local function set_focused_workspace(focused)
	for name, space in pairs(spaces) do
		local selected = name == focused
		space:set({
			icon = {
				color = selected and colors.white or colors.grey,
				highlight = selected,
				highlight_color = colors.white,
			},
			background = {
				drawing = true,
				color = colors.bar.bg,
				border_width = selected and 2 or 0,
				border_color = selected and colors.highlight or colors.transparent,
			},
		})
	end
end

for _, name in ipairs(workspace_names) do
	local space = sbar.add("item", "space." .. name, {
		position = "left",
		icon = {
			string = name,
			font = {
				family = settings.font.text,
				style = settings.font.style_map["Heavy"],
				size = 13.0,
			},
			color = colors.grey,
			padding_left = 10,
			padding_right = 10,
		},
		label = { drawing = false },
		background = {
			drawing = true,
			color = colors.bar.bg,
			height = 28,
			corner_radius = 9,
			border_width = 0,
			border_color = colors.transparent,
		},
		padding_left = 1,
		padding_right = 1,
		click_script = "aerospace workspace " .. name,
	})

	spaces[name] = space
	space:subscribe("mouse.clicked", function()
		sbar.exec("aerospace workspace " .. name)
	end)
end

local function refresh_focused_workspace()
	sbar.exec("aerospace list-workspaces --focused", function(result)
		set_focused_workspace(result:gsub("%s+$", ""))
	end)
end

local function refresh_visible_workspaces()
	local command = "for monitor in $(aerospace list-monitors --format '%{monitor-id}'); do "
		.. "aerospace list-workspaces --monitor \"$monitor\" --empty no; "
		.. "done"
	sbar.exec(command, function(result)
		local used = {}
		for workspace in result:gmatch("[^\r\n]+") do
			used[workspace:gsub("%s+$", "")] = true
		end

		for name, space in pairs(spaces) do
			space:set({ drawing = used[name] == true })
		end
	end)
end

local workspace_observer = sbar.add("item", {
	drawing = false,
	updates = true,
})

workspace_observer:subscribe("aerospace_workspace_change", function(env)
	set_focused_workspace(env.FOCUSED_WORKSPACE or "")
	refresh_visible_workspaces()
end)

refresh_focused_workspace()
refresh_visible_workspaces()
