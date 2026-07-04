#!/usr/bin/env python3
import csv
import sys
from pathlib import Path

SCRIPT_DIR = Path(__file__).resolve().parent
REGISTRY = SCRIPT_DIR.parent / "shell" / "shared" / "themes" / "registry.tsv"

theme = sys.argv[1] if len(sys.argv) > 1 else "catppuccin-macchiato"
theme = theme.lower().strip()

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
    },
    "tokyonight-storm": {
        "name": "Tokyo Night Storm",
        "colors": [
            {"rgb": (36, 40, 59), "name": "Storm", "desc": "Background"},
            {"rgb": (169, 177, 214), "name": "Text", "desc": "Foreground"},
            {"rgb": (247, 118, 142), "name": "Red", "desc": "Errors, Keywords"},
            {"rgb": (158, 206, 106), "name": "Green", "desc": "Strings, Functions"},
            {"rgb": (224, 175, 104), "name": "Yellow", "desc": "Constants, Attributes"},
            {"rgb": (122, 162, 247), "name": "Blue", "desc": "Variables, Parameters"},
            {"rgb": (187, 154, 247), "name": "Purple", "desc": "Operators, Tags"},
            {"rgb": (125, 207, 255), "name": "Cyan", "desc": "Types, Links"},
        ],
        "syntax": {
            "keyword": (187, 154, 247),  # Purple
            "operator": (187, 154, 247), # Purple
            "string": (224, 175, 104),   # Yellow
            "variable": (169, 177, 214), # Text
            "function": (122, 162, 247), # Blue
            "comment": (86, 95, 137),    # Comment
        }
    },
    "rose-pine": {
        "name": "Rose Pine",
        "colors": [
            {"rgb": (25, 23, 36), "name": "Base", "desc": "Background"},
            {"rgb": (224, 222, 244), "name": "Text", "desc": "Foreground"},
            {"rgb": (235, 111, 146), "name": "Love", "desc": "Errors, Keywords"},
            {"rgb": (49, 116, 143), "name": "Pine", "desc": "Strings, Functions"},
            {"rgb": (246, 193, 119), "name": "Gold", "desc": "Constants, Attributes"},
            {"rgb": (156, 205, 216), "name": "Foam", "desc": "Variables, Parameters"},
            {"rgb": (196, 167, 231), "name": "Iris", "desc": "Operators, Tags"},
            {"rgb": (235, 188, 186), "name": "Rose", "desc": "Types, Links"},
        ],
        "syntax": {
            "keyword": (196, 167, 231),  # Iris
            "operator": (196, 167, 231), # Iris
            "string": (246, 193, 119),   # Gold
            "variable": (224, 222, 244), # Text
            "function": (156, 205, 216), # Foam
            "comment": (144, 140, 170),  # Comment
        }
    },
    "gruvbox-dark": {
        "name": "Gruvbox Dark",
        "colors": [
            {"rgb": (40, 40, 40), "name": "Dark0", "desc": "Background"},
            {"rgb": (235, 219, 178), "name": "Fg", "desc": "Foreground"},
            {"rgb": (251, 73, 52), "name": "Red", "desc": "Errors, Keywords"},
            {"rgb": (184, 187, 38), "name": "Green", "desc": "Strings, Functions"},
            {"rgb": (250, 189, 47), "name": "Yellow", "desc": "Constants, Attributes"},
            {"rgb": (131, 165, 152), "name": "Blue", "desc": "Variables, Parameters"},
            {"rgb": (211, 134, 155), "name": "Purple", "desc": "Operators, Tags"},
            {"rgb": (142, 192, 124), "name": "Cyan", "desc": "Types, Links"},
        ],
        "syntax": {
            "keyword": (211, 134, 155),  # Purple
            "operator": (211, 134, 155), # Purple
            "string": (250, 189, 47),    # Yellow
            "variable": (235, 219, 178), # Fg
            "function": (131, 165, 152), # Blue
            "comment": (146, 131, 116),  # Comment
        }
    },
    "kanagawa-wave": {
        "name": "Kanagawa Wave",
        "colors": [
            {"rgb": (31, 31, 40), "name": "Sumi", "desc": "Background"},
            {"rgb": (220, 215, 186), "name": "Fg", "desc": "Foreground"},
            {"rgb": (195, 64, 75), "name": "Red", "desc": "Errors, Keywords"},
            {"rgb": (118, 148, 106), "name": "Green", "desc": "Strings, Functions"},
            {"rgb": (192, 163, 110), "name": "Yellow", "desc": "Constants, Attributes"},
            {"rgb": (126, 156, 216), "name": "Blue", "desc": "Variables, Parameters"},
            {"rgb": (149, 127, 184), "name": "Purple", "desc": "Operators, Tags"},
            {"rgb": (106, 149, 137), "name": "Teal", "desc": "Types, Links"},
        ],
        "syntax": {
            "keyword": (149, 127, 184),  # Purple
            "operator": (149, 127, 184), # Purple
            "string": (192, 163, 110),   # Yellow
            "variable": (220, 215, 186), # Fg
            "function": (126, 156, 216), # Blue
            "comment": (114, 113, 105),  # Comment
        }
    }
}

def registry_names():
    with open(REGISTRY, newline="") as f:
        return {row["name"] for row in csv.DictReader(f, delimiter="\t")}


registry_names_set = registry_names()
if registry_names_set != set(themes.keys()):
    missing_from_dict = registry_names_set - set(themes.keys())
    missing_from_registry = set(themes.keys()) - registry_names_set
    sys.exit(
        "preview-theme.py: color dict and registry.tsv are out of sync.\n"
        f"  in registry, not in preview dict: {sorted(missing_from_dict)}\n"
        f"  in preview dict, not in registry: {sorted(missing_from_registry)}"
    )

theme_clean = theme.replace("\r", "").replace("\n", "").strip()
if theme_clean not in themes:
    sys.exit(f"preview-theme.py: unknown theme '{theme_clean}'")
t = themes[theme_clean]

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
