local dashboard = require("alpha.themes.dashboard")

-- Custom User ASCII Art (NEOVIM Block Style - Corrected)
dashboard.section.header.val = {
    [[######################=###############=*##*=#####################*#######*############]],
    [[##############*#####.=###########################################* +##################]],
    [[*#################: -##################################*##########+  =################]],
    [[####*######*####-  -#+ +.       *##=.   :*#-  .###*   *  .+  =####:  :-=##############]],
    [[###*##########**=  *   +.       *=         *.  =#*   #*  :+    *=   . .############*##]],
    [[######*########-       +.  :::::#   #####   #   *   ##*  :+          * .#########*####]],
    [[##############. =: *:  +.       *   #####   ##     *##*  :+  -*  #=      #############]],
    [[###**########  =####.  +.  :----*.   ---   -##*   +###*  :+  :####=  +*+  ###*########]],
    [[#*#########*  +#####   +.       *##.     -*####* -####*  :+  :####=  :##=  *##########]],
    [[##########=  +######  *############################################* :###-  +#########]],
    [[#########:  +######+*##*#################*###############################*:  =########]],
    [[########.  +***##########################################################*#.  =#######]],
    [[#######   . +#######*##############################################*#**##* -   -######]],
    [[#####+    +###############*###############################################**.   :#####]],
    [[####=  .*######*#####*########################################################:  .####]],
    [[###: :#############*############################################################- .###]],
    [[##.-##############*######################*########################################+ *#]],
    [[*+##################################################################################+*]],
}

-- Ensure centering
dashboard.section.header.opts.position = "center"

dashboard.section.buttons.val = {
    dashboard.button("n", "  New File", ":ene <BAR> startinsert <CR>"),
    dashboard.button("ff", "  Find File", ":Telescope find_files <CR>"),
    dashboard.button("fo", "  Find Note", ":ObsidianQuickSwitch <CR>"),
    dashboard.button("r", "  Recent", ":Telescope oldfiles <CR>"),
    dashboard.button("fw", "  Find Text", ":Telescope live_grep <CR>"),
    dashboard.button("c", "  Config", ":e $MYVIMRC <CR>"),
    dashboard.button("q", "  Quit", ":qa<CR>"),
}

-- Custom Footer
local function footer()
    return "nvchad loaded " .. require("lazy").stats().count .. " plugins"
end
dashboard.section.footer.val = footer()

-- Set nicer colors
vim.api.nvim_set_hl(0, "AlphaHeader", { fg = "#7aa2f7" })  -- Tokyo Blue
vim.api.nvim_set_hl(0, "AlphaButtons", { fg = "#9ece6a" }) -- Soft Green
vim.api.nvim_set_hl(0, "AlphaFooter", { fg = "#565f89" })  -- Muted Gray

return dashboard.config