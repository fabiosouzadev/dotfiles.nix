{
  lib,
  pkgs,
  inputs,
  vars,
  ...
}: let
  rofi-themes = inputs.rofi-themes;
in
  lib.mkIf (vars.wm == "hyprland") {
    wayland.windowManager.hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
      systemd.enable = true;
      extraConfig = builtins.readFile ./conf/hyprland.conf;
    };
    xdg.configFile = {
      "hypr/hyprland.conf".source = ./conf/hyprland.conf;
      "i3/scripts" = {
        source = ./scripts;
        # copy the scripts directory recursively
        recursive = true;
        executable = true; # make all scripts executable
      };
      "waybar/".source = ./waybar;
      # "waybar/config.jsonc".text = builtins.readFile ./waybar/config.jsonc;
      # "waybar/style.css".text = builtins.readFile ./waybar/style.css;
      "hypr/monitor.sh".text = ''
        #! /bin/sh
        hyprctl dispatch dpms on
        hyprctl keyword monitor "eDP-1, preferred, auto, 1"
        hyprctl keyword monitor "HDMI-A-1, 2560x1080@60, 0x0, 1"
      '';
      "hypr/hyprpaper.conf".text = ''
        preload = ~/.config/wallpapers/wide1.jpg
        wallpaper = HDMI-A-1,~/.config/wallpapers/wide1.jpg
      '';
      "hypr/screenshot.sh".text = ''
        #!/bin/sh
        grim -g "$(slurp)" - | wl-copy --type image/png
        notify-send 'Screenshot' 'Screenshot copied to clipboard'
      '';
      "rofi" = {
        source = "${rofi-themes}/files";
        recursive = true;
        executable = true;
      };
    };
    # Pacotes essenciais
    home.packages = with pkgs; [
      # ecosystem
      hyprpicker
      hyprcursor
      hyprlock
      hypridle
      hyprpaper

      waybar
      dunst
      rofi-wayland
      flameshot
      wl-clipboard
      cliphist
      brightnessctl
      slurp
      grim
      wlr-randr

      nwg-displays
      qt6.full
      xdg-utils
    ];
  }
