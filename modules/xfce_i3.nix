{
  pkgs,
  username,
  ...
}: {
  # services.displayManager.defaultSession = '';
  # services.displayManager.autoLogin = '';
  environment.pathsToLink = ["/libexec"];
  programs.dconf.enable = true;
  services.xserver.enable = true;
  services.xserver.desktopManager = {
    xterm.enable = false;
    xfce = {
      enable = true;
      noDesktop = true;
      enableXfwm = false;
    };
  };

  services.xserver.displayManager = {
    defaultSession = "xfce+i3";
    autoLogin = {
      enable = true;
      user = username;
    };
  };

  services.xserver.windowManager.i3 = {
    enable = true;
    package = pkgs.i3-gaps;
    extraPackages = with pkgs; [
      i3lock
      i3blocks
      xautolock # lock screen after some time
      feh # set wallpaper
      dex # autostart applications
      xbindkeys # bind keys to commands
      xorg.xbacklight # control screen brightness
      xorg.xdpyinfo # get screen information
      sysstat # get system information
      acpi # battery information
      dmenu
    ];
  };

  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-volman
    ];
  };

  services.autorandr.enable = true;
  services.gvfs.enable = true;
  services.tumbler.enable = true;
}
