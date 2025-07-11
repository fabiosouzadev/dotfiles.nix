#!/usr/bin/env bash
# Detecta monitores usando wlr-randr
outputs=$(wlr-randr | awk '/^[^ ]+ / {print $1}')

for output in $outputs; do
  wlr-randr --output $output --pos 0,0 --preferred
done

# Define wallpaper
# hyprctl hyprpaper preload ~/.config/wallpapers/*
# hyprctl hyprpaper wallpaper "eDP-1,~/.config/wallpapers/$(ls ~/.config/wallpapers | shuf -n 1)"
