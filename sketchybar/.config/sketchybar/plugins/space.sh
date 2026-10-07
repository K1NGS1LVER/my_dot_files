#!/bin/sh

source "$CONFIG_DIR/colors.sh"

focused="${FOCUSED_WORKSPACE:-$(aerospace list-workspaces --focused)}"
occupied="$(aerospace list-workspaces --monitor all --empty no)"
ws="${NAME#space.}"

if [ "$ws" = "$focused" ]; then
  sketchybar --set "$NAME" drawing=on background.drawing=on \
                         background.color=$ITEM_BG_COLOR \
                         background.border_color=$WHITE \
                         background.border_width=2 \
                         icon.color=$WHITE
elif printf '%s\n' "$occupied" | grep -Fxq "$ws"; then
  sketchybar --set "$NAME" drawing=on background.drawing=on \
                         background.color=$ITEM_BG_COLOR \
                         background.border_width=0 \
                         icon.color=$WHITE
else
  sketchybar --set "$NAME" drawing=off background.drawing=off \
                         background.border_width=0 icon.color=$WHITE
fi
