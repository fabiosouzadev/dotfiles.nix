{
  pkgs,
  username,
  ...
}: {
  ####################################################################
  #  NixOS's Configuration for Xfce4 Desktop Environment
  ####################################################################

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the Xfce4 Desktop Environment.
  services.xserver.desktopManager.xterm.enable = false;
  services.xserver.desktopManager.xfce.enable = true;
  services.xserver.desktopManager.xfce.noDesktop = true;
  services.xserver.desktopManager.xfce.enableXfwm = false;

  #XFCE4 Desktop Environment + i3 window manager
  services.xserver.windowManager.i3.enable = true;
  services.xserver.displayManager.defaultSession = "xfce+i3";
  services.xserver.displayManager.lightdm.enable = true;

  # Enable automatic login for the user.
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = username;

  environment.systemPackages = with pkgs; [
    xarchiver
    xfce.ristretto
    xfce.xfce4-volumed-pulse
    xfce.xfce4-screenshooter
    xfce.xfce4-clipman-plugin
    xfce.xfce4-pulseaudio-plugin
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
  nixpkgs.config.pulseaudio = true;
}
