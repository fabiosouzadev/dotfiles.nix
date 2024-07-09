{
  lib,
  pkgs,
  ...
}: {
  xsession = {
    enable = true;
    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
      config = lib.mkForce null; # ignores all home-manager's default i3 config
      extraConfig = builtins.readFile ./conf/i3-config;
    };
    # Path, relative to HOME, where Home Manager should write the X session script.
    # and NixOS will use it to start xorg session when system boot up
    scriptPath = ".xsession";
  };

  home.packages = with pkgs; [
    i3lock
    i3blocks
    xautolock # lock screen after some time
    feh # set wallpaper
    dex # autostart applications
    xbindkeys # bind keys to commands
    xorg.xbacklight # control screen brightness
    xorg.xdpyinfo # get screen information
    acpi # battery information

    dmenu
    networkmanager_dmenu
    polybarFull # all for polybar
    rofi
    pywal
    calc
    xcolor
    #dust
  ];

  xdg.configFile = {
    "i3/scripts" = {
      source = ./conf/scripts;
      # copy the scripts directory recursively
      recursive = true;
      executable = true; # make all scripts executable
    };
  };

  home.file = {
    # xrandr - set primary screen
    "/.config/wallpapers" = {
      source = ../../wallpapers;
      recursive = true;
    };
    "/.screenlayout/i3_detect_displays.sh".source = ./conf/i3_detect_displays.sh;
    ".config/polybar" = {
      source = ./conf/polybar;
      recursive = true;
      executable = true;
    };
  };
}
