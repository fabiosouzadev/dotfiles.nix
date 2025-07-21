{
  lib,
  pkgs,
  inputs,
  vars,
  ...
}: let
  rofi-themes = inputs.rofi-themes;
  my-wallpapers = inputs.wallpapers;
in
  lib.mkIf (vars.wm == "hyprland") {
    wayland.windowManager.hyprland = {
      enable = true;
      # package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      # portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
      systemd.enable = true;
      extraConfig = builtins.readFile ./hypr/hyprland.conf;
    };
    xdg.configFile = {
      # "hypr/".source = ./hypr;
      "hypr/scripts" = {
        source = ./scripts;
        # copy the scripts directory recursively
        recursive = true;
        executable = true; # make all scripts executable
      };
      "waybar/".source = ./waybar;
      "rofi" = {
        source = "${rofi-themes}/files";
        recursive = true;
        executable = true;
      };
      "dunst/dunstrc".source = ../dunst/dunstrc;
      "wallpapers" = {
        source = "${my-wallpapers}";
        recursive = true;
      };
    };

    home.file = {
      ".local/share/fonts/rofi".source = "${rofi-themes}/fonts";
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
