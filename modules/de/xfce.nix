{
  pkgs,
  lib,
  vars,
  ...
}:
lib.mkIf (vars.de == "xfce") {
  ####################################################################
  #  NixOS's Configuration for Xfce4 Desktop Environment
  ####################################################################

  services = {
    xserver = {
      # Enable the X11 windowing system.
      enable = true;
      # Enable the Xfce4 Desktop Environment.
      desktopManager = {
        xterm.enable = false;
        xfce.enable = true;
        xfce.noDesktop = lib.mkIf (vars.wm == "i3") false;
        xfce.enableXfwm = false;
      };
      displayManager.lightdm.enable = lib.mkDefault true;
    };

    displayManager = {
      #XFCE4 Desktop Environment + i3 window manager
      #services.xserver.windowManager.i3.enable = true;
      defaultSession = "xfce";

      # Enable automatic login for the user.
      autoLogin = {
        enable = true;
        user = vars.username;
      };
    };
  };

  environment.systemPackages = with pkgs; [
    xarchiver
    # alsa-utils
    xfce.ristretto
    xfce.xfce4-screenshooter
  ];

  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-volman
      thunar-media-tags-plugin
    ];
  };
  programs.xfconf.enable = true;
  programs.dconf.enable = true;
  programs.file-roller.enable = true;
  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.tumbler.enable = true; # Thumbnail support for images
  # nixpkgs.config.pulseaudio = true;
  #services.gnome.gnome-keyring.enable = lib.mkForce false;
  #security.pam.services.gdm.enableGnomeKeyring = true;
}
