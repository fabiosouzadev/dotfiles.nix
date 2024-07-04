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

  home-manager.users.${username} = {
    home.file."/.config/i3/config".source = ../home/i3/i3/config;
    home.file."/.config/i3/scripts" = {
      source = ../home/i3/scripts;
      recursive = true;
      executable = true; # make all scripts executable
    };
    home.file."/.screenlayout/i3_detect_displays.sh" = {
      source = ../home/i3/scripts/displays/i3_detect_displays.sh;
      executable = true; # make all scripts executable
    };

    home.file."/.config/i3blocks/config".source = ../home/i3/i3blocks/config;

    home.file."/.config/i3blocks/scripts" = {
      source = ../home/i3/i3blocks/scripts;
      recursive = true;
      executable = true;
    };

    home.file."/.config/wallpapers" = {
      source = ../home/wallpapers;
      recursive = true;
    };
  };
}
