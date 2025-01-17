#
#  Gnome Configuration
#  Enable with "gnome.enable = true;"
#  View dconf changes with $ dconf watch /
#
####################################################################
#  NixOS's Configuration for Gnome Desktop Environment
####################################################################
{
  config,
  lib,
  pkgs,
  vars,
  ...
}: {
  options = {
    gnome = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
      };
    };
  };

  config = lib.mkIf (config.gnome.enable) {
    services = {
      xserver = {
        # Enable the X11 windowing system.
        # enable = lib.mkIf (vars.de == "gnome") true;
        enable = true;
        # Enable the Xfce4 Desktop Environment.
        desktopManager.gnome.enable = lib.mkIf (vars.de == "gnome") true;
        displayManager.gdm.enable = true;
      };

      displayManager = {
        # #XFCE4 Desktop Environment + i3 window manager
        # #services.xserver.windowManager.i3.enable = true;
        # defaultSession =
        #   if (vars.wm == "i3")
        #   then "xfce+i3"
        #   else "xfce";

        # Enable automatic login for the user.
        autoLogin = {
          enable = true;
          user = vars.username;
        };
      };
    };
    environment.gnome.excludePackages =
      (with pkgs; [
        gnome-photos
        gnome-tour
      ])
      ++ (with pkgs; [
        cheese # webcam tool
        gnome-music
        gedit # text editor
        epiphany # web browser
        geary # email reader
        gnome-characters
        tali # poker game
        iagno # go game
        hitori # sudoku game
        atomix # puzzle game
        yelp # Help view
        gnome-contacts
        gnome-initial-setup
      ]);
    environment.systemPackages = with pkgs; [
      adwaita-icon-theme
      gnome-tweaks
    ];

    programs.dconf.enable = true;
    services.udev.packages = [pkgs.gnome-settings-daemon];
    systemd.services."getty@tty1".enable = false;
    systemd.services."autovt@tty1".enable = false;
  };
}
