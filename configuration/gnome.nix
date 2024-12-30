{...}: {
  ####################################################################
  #  NixOS's Configuration for Gnome Desktop Environment
  ####################################################################

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.gdm.wayland = false;
  services.xserver.desktopManager.gnome.enable = true;

  nixpkgs.config.pulseaudio = false;
}
