#!/bin/bash

sketchybar --add item ram right \
           --set ram  update_freq=5 \
                      icon=􀫦  \
                      script="$PLUGIN_DIR/ram.sh" \
                      click_script="defaults write com.apple.ActivityMonitor SelectedTab -int 1; killall 'Activity Monitor' 2>/dev/null; sleep 0.1; open -a 'Activity Monitor'"