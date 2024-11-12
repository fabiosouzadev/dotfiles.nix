{
  lib,
  pkgs,
  inputs,
  ...
}: let
  rofi-themes = inputs.rofi-themes;
  polybar-themes = inputs.polybar-themes;
in {
  xsession = {
    enable = true;
    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
      config = lib.mkForce null; # ignores all home-manager's default i3 config
      extraConfig = builtins.readFile ./conf/i3-config.conf;
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
    acpi # battery information
    sysstat # get system information
    dmenu
    networkmanager_dmenu
    polybarFull # all for polybar
    rofi
    haskellPackages.greenclip
    picom
    pywal
    calc
    xcolor
    dunst
    papirus-icon-theme
    viewnior
    xdotool
  ];

  xdg.configFile = {
    "i3/scripts" = {
      source = ./conf/scripts;
      # copy the scripts directory recursively
      recursive = true;
      executable = true; # make all scripts executable
    };
    "dunst/dunstrc".source = ./conf/dunst/dunstrc;
    "polybar" = {
      source = "${polybar-themes}/simple";
      recursive = true;
      executable = true;
    };
    "rofi" = {
      source = "${rofi-themes}/files";
      recursive = true;
      executable = true;
    };
    "wallpapers" = {
      source = ../../wallpapers;
      recursive = true;
    };
    "picom/picom.conf".source = ./conf/picom/picom.conf;
    "greenclip.toml".source = ./conf/greenclip/greenclip.toml;
  };

  home.file = {
    # xrandr - set primary screen
    "/.screenlayout/i3_detect_displays.sh".source = ./conf/i3_detect_displays.sh;
    ".local/share/fonts/rofi".source = "${rofi-themes}/fonts";
    ".local/share/fonts/polybar".source = "${polybar-themes}/fonts";
  };
}
