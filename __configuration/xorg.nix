{pkgs, ...}: {
  ####################################################################
  #  NixOS's Configuration for Xorg Server
  ####################################################################

  environment.pathsToLink = ["/libexec"];
  programs.dconf.enable = true;

  environment.systemPackages = with pkgs.xorg; [
    xbacklight # control screen brightness
    xdpyinfo # get screen information
    xkbcomp # compile keymaps
  ];
}
