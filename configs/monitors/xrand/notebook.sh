#!/bin/sh
xrandr --output eDP-1 --primary --mode 1366x768 --pos 0x0 --rotate normal --output DP-1 --off --output DP-2 --off --output HDMI-1 --off --output VIRTUAL-1 --off && \
feh --bg-fill --randomize $HOME/.config/wallpapers