#!/bin/bash

sketchybar --add item cpu right \
           --set cpu  update_freq=2 \
                      icon=􀫥  \
                      script="$PLUGIN_DIR/cpu.sh" \
                      click_script="defaults write com.apple.ActivityMonitor SelectedTab -int 0; killall 'Activity Monitor' 2>/dev/null; sleep 0.1; open -a 'Activity Monitor'"
