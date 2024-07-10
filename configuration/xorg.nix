{
  pkgs,
  username,
  ...
}: {
  ####################################################################
  #  NixOS's Configuration for Xorg Server
  ####################################################################

  environment.pathsToLink = ["/libexec"];
  programs.dconf.enable = true;
  programs.thunar.enable = true;
  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.tumbler.enable = true; # Thumbnail support for images
  # autorandr.enable = true;

  services.xserver.enable = true;
  services.xserver.windowManager.i3.enable = true;
  services.xserver.desktopManager = {
    xterm.enable = false;
    xfce = {
      enable = true;
      noDesktop = true;
      enableXfwm = false;
    };
  };
  services.xserver.displayManager = {
    lightdm.enable = true;
    autoLogin = {
      enable = true;
      user = username;
    };
    # use a fake session to skip desktop manager
    # and let Home Manager take care of the X session
    defaultSession = "xfce";
  };
}
