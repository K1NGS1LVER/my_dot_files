// Surfingkeys Configuration - Vimium C Style with Larger Hints

// ============================================
// HINT STYLE - LARGER FONTS
// ============================================
Hints.style(`
  font-size: 16px !important;
  font-family: Arial, Helvetica, sans-serif !important;
  font-weight: bold !important;
  color: #ffffff !important;
  background-color: #f57c00 !important;
  border: 2px solid #e65100 !important;
  border-radius: 4px !important;
  padding: 5px 8px !important;
  text-transform: uppercase !important;
  box-shadow: 0 3px 6px rgba(0,0,0,0.4) !important;
  min-width: 24px !important;
  text-align: center !important;
  line-height: 1.2 !important;
  letter-spacing: 1px !important;
`);

// Style for text hints (visual mode)
Hints.style(
	`
  font-size: 14px !important;
  font-weight: bold !important;
  background-color: #4caf50 !important;
  border: 2px solid #388e3c !important;
`,
	"text",
);

// ============================================
// SETTINGS
// ============================================
settings.smoothScroll = true;
settings.scrollStepSize = 100;
settings.hintAlign = "center";
settings.omnibarPosition = "middle";
settings.focusFirstCandidate = true;
settings.tabsThreshold = 0;
settings.historyMUOrder = false;
settings.newTabPosition = "right";

// ============================================
// SCROLL MAPPINGS (Vim-like)
// ============================================
api.map("j", "j");
api.map("k", "k");
api.map("h", "h");
api.map("l", "l");
api.map("d", "d");
api.map("u", "u");
api.map("gg", "gg");
api.map("G", "G");

// ============================================
// LINK HINTS
// ============================================
api.map("f", "f");
api.map("F", "gf"); // Open link in new background tab (Vimium F style)

// ============================================
// NAVIGATION
// ============================================
api.map("H", "S");
api.map("L", "D");
api.map("r", "r");
api.map("R", "R");

// ============================================
// TAB OPERATIONS
// ============================================
api.map("J", "R");
api.map("K", "E");
api.map("gt", "R");
api.map("gT", "E");
api.map("g0", "g0");
api.map("g$", "g$");
api.map("t", "on");
api.map("x", "x");
api.map("X", "X");
api.map("yt", "yt");
api.map("gp", "gp");
api.map("gm", "gm");

// ============================================
// URL/OMNIBAR
// ============================================
api.map("o", "go");
api.map("O", "t");
api.map("b", "b");
api.map("B", "B");
api.map("T", "T");

// ============================================
// SEARCH
// ============================================
api.map("/", "/");
api.map("n", "n");
api.map("N", "N");

// ============================================
// CLIPBOARD
// ============================================
api.map("yy", "yy");
api.map("yf", "yf");
api.map("p", "p");
api.map("P", "P");

// ============================================
// INPUT/FOCUS
// ============================================
api.map("gi", "gi");
api.map("i", "i");

// ============================================
// URL MANIPULATION
// ============================================
api.map("ge", ";U");
api.map("gE", ";u");
api.map("gu", "gu");
api.map("gU", "gU");
api.map("gs", ";s");

// ============================================
// VISUAL MODE
// ============================================
api.map("v", "v");

// ============================================
// TAB MOVEMENT
// ============================================
api.map("<<", "<<");
api.map(">>", ">>");

// ============================================
// ZOOM
// ============================================
api.map("zi", "zi");
api.map("zo", "zo");
api.map("zr", "zr");

// ============================================
// MARKS
// ============================================
api.map("m", "m");
api.map("'", "'");

// ============================================
// FRAMES
// ============================================
api.map("gf", "w"); // Cycle through frames
api.map("gF", "W");

// ============================================
// HELP
// ============================================
api.map("?", "?");

// ============================================
// CUSTOM FUNCTIONS
// ============================================

// Quick scroll
api.mapkey("<Ctrl-d>", "Scroll down half page", function () {
	window.scrollBy(0, window.innerHeight / 2);
});

api.mapkey("<Ctrl-u>", "Scroll up half page", function () {
	window.scrollBy(0, -window.innerHeight / 2);
});

// ============================================
// SEARCH ENGINES
// ============================================
api.removeSearchAlias("b");
api.removeSearchAlias("d");
api.removeSearchAlias("w");
api.removeSearchAlias("s");
api.removeSearchAlias("h");

api.addSearchAlias("g", "Google", "https://www.google.com/search?q=");
api.addSearchAlias("y", "YouTube", "https://www.youtube.com/results?search_query=");
api.addSearchAlias("w", "Wikipedia", "https://en.wikipedia.org/wiki/Special:Search?search=");
api.addSearchAlias("gh", "GitHub", "https://github.com/search?q=");
api.addSearchAlias("r", "Reddit", "https://www.reddit.com/search/?q=");
api.addSearchAlias("a", "Amazon", "https://www.amazon.com/s?k=");

// ============================================
// OMNIBAR STYLE
// ============================================
settings.theme = `
.sk_theme {
    font-family: Arial, sans-serif;
    font-size: 14px;
    background: #1e1e1e;
    color: #ffffff;
}
.sk_theme tbody {
    color: #ffffff;
}
.sk_theme input {
    color: #ffffff;
    font-size: 16px;
}
.sk_theme .url {
    color: #8ab4f8;
}
.sk_theme .annotation {
    color: #9aa0a6;
}
.sk_theme .omnibar_highlight {
    color: #f28b82;
}
.sk_theme .omnibar_folder {
    color: #81c995;
}
.sk_theme .omnibar_timestamp {
    color: #9aa0a6;
}
.sk_theme .omnibar_visitcount {
    color: #9aa0a6;
}
.sk_theme .focused {
    background: #3c4043;
}
.sk_theme #sk_omnibarSearchArea {
    border-bottom: 1px solid #5f6368;
}
`;
