
#!/bin/sh
xrandr --newmode "2560x1080x49.94"  150.25  2560 2608 2640 2720  1080 1083 1087 1106  +HSync -VSync

if [ "$XDG_SESSION_TYPE" == "wayland" ]; then
    xrandr --addmode XWAYLAND0 2560x1080x49.94
else 
    xrandr --addmode HDMI-1 2560x1080x49.94
fi

xrandr --output eDP-1 --mode 1920x1080 --pos 2560x0 --rotate normal --output HDMI-1 --primary --mode 2560x1080x49.94 --pos 0x0 --rotate normal && \
    feh --bg-fill --randomize $HOME/.config/wallpapers

