#!/usr/bin/env python3
import sys

theme = sys.argv[1] if len(sys.argv) > 1 else "catppuccin-macchiato"

themes = {
    "catppuccin-macchiato": {
        "name": "Catppuccin Macchiato",
        "colors": [
            {"rgb": (36, 39, 58), "name": "Base", "desc": "Background"},
            {"rgb": (202, 211, 245), "name": "Text", "desc": "Foreground"},
            {"rgb": (237, 135, 150), "name": "Red", "desc": "Errors, Keywords"},
            {"rgb": (166, 218, 149), "name": "Green", "desc": "Strings, Functions"},
            {"rgb": (238, 212, 159), "name": "Yellow", "desc": "Constants, Attributes"},
            {"rgb": (138, 173, 244), "name": "Blue", "desc": "Variables, Parameters"},
            {"rgb": (198, 160, 246), "name": "Mauve", "desc": "Operators, Tags"},
            {"rgb": (139, 213, 202), "name": "Teal", "desc": "Types, Links"},
        ],
        "syntax": {
            "keyword": (198, 160, 246),  # Mauve
            "operator": (198, 160, 246), # Mauve
            "string": (166, 218, 149),   # Green
            "variable": (202, 211, 245), # Text
            "function": (138, 173, 244), # Blue
            "comment": (110, 115, 141),  # Comment
        }
    },
    "monokai-pro": {
        "name": "Monokai Pro (Classic)",
        "colors": [
            {"rgb": (45, 42, 46), "name": "Charcoal", "desc": "Background"},
            {"rgb": (252, 252, 250), "name": "Text", "desc": "Foreground"},
            {"rgb": (255, 97, 136), "name": "Pink", "desc": "Errors, Keywords"},
            {"rgb": (169, 220, 118), "name": "Green", "desc": "Strings, Functions"},
            {"rgb": (255, 216, 102), "name": "Yellow", "desc": "Constants, Attributes"},
            {"rgb": (252, 152, 103), "name": "Orange", "desc": "Variables, Parameters"},
            {"rgb": (171, 157, 242), "name": "Purple", "desc": "Operators, Tags"},
            {"rgb": (120, 220, 232), "name": "Cyan", "desc": "Types, Links"},
        ],
        "syntax": {
            "keyword": (255, 97, 136),   # Pink
            "operator": (255, 97, 136),  # Pink
            "string": (255, 216, 102),   # Yellow
            "variable": (252, 252, 250), # Text
            "function": (169, 220, 118), # Green
            "comment": (114, 112, 114),  # Comment
        }
    }
}

theme_clean = theme.lower().replace("\r", "").replace("\n", "").strip()
t = themes.get(theme_clean, themes["catppuccin-macchiato"])

def fg_col(rgb, text):
    return f"\x1b[38;2;{rgb[0]};{rgb[1]};{rgb[2]}m{text}\x1b[0m"

def bg_col(rgb, text):
    return f"\x1b[48;2;{rgb[0]};{rgb[1]};{rgb[2]}m{text}\x1b[0m"

print(fg_col(t["colors"][6]["rgb"], f" 󰏘  {t['name']} "))
print("-" * 45)

for c in t["colors"]:
    name_spaced = c["name"].ljust(10)
    print(f" {bg_col(c['rgb'], '      ')} {fg_col(c['rgb'], name_spaced)} {fg_col((150, 150, 150), '(' + c['desc'] + ')')}")

print("-" * 45)

s = t["syntax"]
print(fg_col(s["comment"], "  # Code Syntax Preview"))
print(f"  {fg_col(s['keyword'], 'local')} my_var {fg_col(s['operator'], '=')} {fg_col(s['string'], '\"Hello World\"')}")
print(f"  {fg_col(s['keyword'], 'if')} my_var {fg_col(s['operator'], '==')} {fg_col(s['string'], '\"Hello World\"')} {fg_col(s['keyword'], 'then')}")
print(f"      {fg_col(s['function'], 'print')}{fg_col(t['colors'][1]['rgb'], '(')}{fg_col(s['string'], '\"Theme is active!\"')}{fg_col(t['colors'][1]['rgb'], ')')}")
print(f"  {fg_col(s['keyword'], 'end')}")
