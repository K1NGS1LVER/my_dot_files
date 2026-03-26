config.load_autoconfig(False)

# Aesthetics & Glass Theme
c.fonts.default_family = "JetBrains Mono"
c.fonts.default_size = "15px"
c.colors.webpage.bg = "transparent"
c.colors.statusbar.normal.bg = "rgba(33, 37, 43, 0.7)"
c.colors.statusbar.insert.bg = "rgba(152, 195, 121, 0.7)"
c.colors.completion.even.bg = "rgba(40, 44, 52, 0.8)"
c.colors.completion.odd.bg = "rgba(40, 44, 52, 0.8)"
c.statusbar.padding = {"bottom": 2, "left": 2, "right": 2, "top": 2}
c.tabs.padding = {"bottom": 5, "left": 5, "right": 5, "top": 5}

# Translucency (macOS native)
c.window.transparent = True
c.colors.tabs.even.bg = "rgba(40, 44, 52, 0.8)"
c.colors.tabs.odd.bg = "rgba(40, 44, 52, 0.8)"
c.colors.tabs.bar.bg = "#00000000"

# Privacy & Fingerprinting (Section 3)
c.content.canvas_reading = False
c.content.webgl = False
c.content.headers.user_agent = (
    "Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101 Firefox/68.0"
)
c.content.headers.accept_language = "en-US,en;q=0.5"

# Adblocking
c.content.blocking.enabled = True
c.content.blocking.method = "adblock"

# JavaScript Control (Section 5)
config.set("content.javascript.enabled", True)
config.bind("<Space>je", "set content.javascript.enabled true")
config.bind("<Space>jd", "set content.javascript.enabled false")

# Session Management (Section 4)
config.bind("<Space>ss", "set-cmd-text -s :session-save")
config.bind("<Space>sl", "set-cmd-text -s :session-load")
config.bind("<Space>sd", "set-cmd-text -s :session-delete")

# GUI Browser Parity & Muscle Memory
config.bind('<Meta-r>', 'reload')
config.bind('<Meta-Shift-r>', 'reload -f')
config.bind('<Meta-l>', 'set-cmd-text -s :open ')
config.bind('<Meta-f>', 'set-cmd-text /')
config.bind('<Meta-t>', 'set-cmd-text -s :open -t ')
config.bind('<Meta-w>', 'tab-close')
config.bind('<Meta-Shift-t>', 'undo')
config.bind('<Meta-z>', 'undo')
config.bind('<Meta-n>', 'open -w')
config.bind('<Meta-Shift-n>', 'open -p')
config.bind('<Meta-Left>', 'back')
config.bind('<Meta-Right>', 'forward')
config.bind('<Meta-=>', 'zoom-in')
config.bind('<Meta-->', 'zoom-out')
config.bind('<Meta-0>', 'zoom')
config.bind('<Meta-d>', 'bookmark-add')

# Scrolling & Interaction
c.scrolling.smooth = True
config.bind('j', 'scroll-px 0 150')
config.bind('k', 'scroll-px 0 -150')
config.bind('a', 'mode-enter insert')

# "Kill Sticky" Script (Section 2)
config.bind(
    "kse",
    "jseval (function () { "
    + '  var i, elements = document.querySelectorAll("body *");'
    + "  for (i = 0; i < elements.length; i++) {"
    + "    var pos = getComputedStyle(elements[i]).position;"
    + '    if (pos === "fixed" || pos == "sticky") {'
    + "      elements[i].parentNode.removeChild(elements[i]);"
    + "    }"
    + "  }"
    + "})();",
)

# General Rice & Bells/Whistles
c.input.partial_timeout = 3000
c.keyhint.delay = 0
c.tabs.position = "top"
c.tabs.show = "switching"
c.window.hide_decoration = True
c.colors.webpage.darkmode.enabled = True
c.content.autoplay = False
c.content.geolocation = False
c.content.notifications.enabled = False
c.confirm_quit = ["multiple-tabs", "downloads"]

# Custom Bindings for Userscripts
config.bind("pv", "spawn --userscript view-in-mpv")
config.bind("pb", "spawn --userscript qute-bitwarden")
config.bind("<Space>gm", 'spawn open "/Users/dan/Library/Application Support/qutebrowser/greasemonkey/"')
