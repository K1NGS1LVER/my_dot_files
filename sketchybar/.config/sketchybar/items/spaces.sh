#!/bin/bash

WORKSPACES=(1 2 3 4 5 6 7 8 9 A D E M N O P Q R S U V X Y Z)

for ws in "${WORKSPACES[@]}"
do
  sketchybar --add item space.$ws left                                 \
             --set space.$ws icon=$ws                                  \
                             icon.padding_left=10                       \
                             icon.padding_right=10                      \
                             background.color=$ITEM_BG_COLOR          \
                             background.corner_radius=5                \
                             background.height=26                      \
                             label.drawing=off                         \
                             script="$PLUGIN_DIR/space.sh"             \
                             update_freq=5                             \
                             click_script="aerospace workspace $ws"    \
             --subscribe space.$ws aerospace_workspace_change
done
