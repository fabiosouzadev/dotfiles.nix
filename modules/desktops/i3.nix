{ pkgs, ...}:


{

  # i3 related options
  environment.pathsToLink = [ "/libexec" ]; # links /libexec from derivations to /run/current-system/sw
  services.xserver = {
    # Enable the X11 windowing system.
    enable = true;

    desktopManager = {
      xterm.enable = false;
      # xfce = {
      #   enable = true;
      #   noDesktop = true;
      #   enableXfwm = false;
      # }
    };

    displayManager = {
        defaultSession = "none+i3";
        lightdm.enable = true;
        #gdm.enable = true;
        autoLogin = {
            enable = true;
            user = "fabiosouzadev";
        };
    };

    windowManager.i3 = {
      enable = true;
      extraSessionCommands = ''
        ${pkgs.feh}/bin/feh --bg-fill --randomize $HOME/.config/wallpapers
        ${pkgs.dunst}/bin/dunst --config $HOME/.config/dunst/dunstrc &
      '';
      extraPackages = with pkgs; [
        i3blocks      # status bar
        i3lock        # default i3 screen locker
        i3status      # provide information to i3bar
        i3-gaps       # i3 with gaps
        xautolock     # lock screen after some time
        rofi          # application launcher, the same as dmenu
        dunst         # notification daemon
        libnotify     # to dunst works
        picom         # transparency and shadows
        feh           # set wallpaper
        flameshot     # screenshots
        acpi          # battery information
        arandr        # screen layout manager
        dex           # autostart applications
        xbindkeys        # bind keys to commands
        xorg.xbacklight  # control screen brightness
        xorg.xdpyinfo    # get screen information
        sysstat          # get system information
        nitrogen
        polybarFull      # all for polybar
        haskellPackages.greenclip
        papirus-icon-theme
        dmenu
     ];
    };

  };

  #environment.etc."xdg/i3/config".text = import ../../configs/i3/i3-config.nix;
  environment.etc."xdg/i3/config".text = pkgs.callPackage ../configs/i3/i3-config.nix {};
  home-manager.users.${defaultUser} = {
    home.file."/.config/wallpapers" = {
    source = ../../configs/wallpapers;
    recursive = true;
    };
    
    home.file."/.config/i3/scripts" = {
    source = ../../configs/i3/scripts;
    recursive = true;
    executable = true;  # make all scripts executable
    };
    
    home.file."/.config/i3/scripts/displays" = {
    source = ../../configs/i3/scripts/displays;
    recursive = true;
    executable = true;  # make all scripts executable
    };

    home.file."/.config/picom/picom.conf".source = ../../configs/picom/picom.conf;

    home.file."/.config/rofi" = {
    source = ../../configs/rofi;
    recursive = true;
    };

    home.file."/.config/dunst" = {
    source = ../../configs/dunst;
    recursive = true;
    };

    home.file."/.config/polybar" = {
    source = ../../configs/polybar;
    recursive = true;
    };
  };
}
