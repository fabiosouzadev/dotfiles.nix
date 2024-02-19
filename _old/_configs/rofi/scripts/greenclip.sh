#!/usr/bin/env bash

#rofi \
#    -modi "clipboard:greenclip print" \
#    -show clipboard \
#	-config ~/.config/rofi/launchers/rofidmenu.rasi


rofi \
    -no-config \
    -no-lazy-grab \
    -show clipboard \
    -modi "clipboard:greenclip print" \
    -theme ~/.config/rofi/launchers/launcher.rasi &
