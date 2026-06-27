#!/usr/bin/env python3
import sys

theme = sys.argv[1] if len(sys.argv) > 1 else "catppuccin-macchiato"

themes = {
    "catppuccin-macchiato": {
        "name": "Catppuccin Macchiato",
        "bg": (36, 39, 58),
        "fg": (202, 211, 245),
        "red": (237, 135, 150),
        "green": (166, 218, 149),
        "yellow": (238, 212, 159),
        "blue": (138, 173, 244),
        "purple": (198, 160, 246),
        "cyan": (139, 213, 202),
        "comment": (110, 115, 141),
    },
    "monokai-pro": {
        "name": "Monokai Pro (Classic)",
        "bg": (45, 42, 46),
        "fg": (252, 252, 250),
        "red": (255, 97, 136),
        "green": (169, 220, 118),
        "yellow": (255, 216, 102),
        "blue": (252, 152, 103),  # Orange/Blue accent
        "purple": (171, 157, 242),
        "cyan": (120, 220, 232),
        "comment": (114, 112, 114),
    }
}

t = themes.get(theme, themes["catppuccin-macchiato"])

def fg_col(rgb, text):
    return f"\x1b[38;2;{rgb[0]};{rgb[1]};{rgb[2]}m{text}\x1b[0m"

def bg_col(rgb, text):
    return f"\x1b[48;2;{rgb[0]};{rgb[1]};{rgb[2]}m{text}\x1b[0m"

print(fg_col(t["purple"], f" 󰏘  {t['name']} "))
print("-" * 45)
print(f" {bg_col(t['bg'], '      ')} {fg_col(t['fg'], 'Background/Foreground')}")
print(f" {bg_col(t['red'], '      ')} {fg_col(t['red'], 'Red')}     (Errors, Keywords)")
print(f" {bg_col(t['green'], '      ')} {fg_col(t['green'], 'Green')}   (Strings, Functions)")
print(f" {bg_col(t['yellow'], '      ')} {fg_col(t['yellow'], 'Yellow')}  (Constants, Attributes)")
print(f" {bg_col(t['blue'], '      ')} {fg_col(t['blue'], 'Blue')}    (Variables, Parameters)")
print(f" {bg_col(t['purple'], '      ')} {fg_col(t['purple'], 'Purple')}  (Operators, Tags)")
print(f" {bg_col(t['cyan'], '      ')} {fg_col(t['cyan'], 'Cyan')}    (Types, Links)")
print("-" * 45)
print(fg_col(t['comment'], "  # Code Syntax Preview"))
print(f"  {fg_col(t['purple'], 'local')} my_var {fg_col(t['purple'], '=')} {fg_col(t['green'], '\"Hello World\"')}")
print(f"  {fg_col(t['purple'], 'if')} my_var {fg_col(t['purple'], '==')} {fg_col(t['green'], '\"Hello World\"')} {fg_col(t['purple'], 'then')}")
print(f"      {fg_col(t['blue'], 'print')}{fg_col(t['fg'], '(')}{fg_col(t['green'], '\"Theme is active!\"')}{fg_col(t['fg'], ')')}")
print(f"  {fg_col(t['purple'], 'end')}")
