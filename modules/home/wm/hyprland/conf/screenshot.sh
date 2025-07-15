#!/bin/sh
grim -g "$(slurp)" - | wl-copy --type image/png
notify-send 'Screenshot' 'Screenshot copied to clipboard'
