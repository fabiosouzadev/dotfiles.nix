{pkgs, ...}:


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
        lightdm.enable = false;
        gdm.enable = true;
    };

    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        i3blocks      # status bar
        i3lock        # default i3 screen locker
        i3status      # provide information to i3bar
        i3-gaps       # i3 with gaps
        xautolock     # lock screen after some time
        rofi          # application launcher, the same as dmenu
        dunst         # notification daemon
        picom         # transparency and shadows
        feh           # set wallpaper
        flameshot     # screenshots
        acpi          # battery information
        arandr        # screen layout manager
        dex           # autostart applications
        xbindkeys     # bind keys to commands
        xorg.xbacklight  # control screen brightness
        xorg.xdpyinfo      # get screen information
        sysstat       # get system information
        nitrogen
        polybar
        haskellPackages.greenclip
        # polkit_gnome
        # pulseaudioFull
        # networkmanagerapplet
        # gnome.gnome-keyring
        # dmenu
     ];
    };

    # Configure keymap in X11
    xkb = {
    	layout = "us";
    	variant = "alt-intl";
    };
  };

  # Configure console keymap
  console.keyMap = "dvorak";

  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.tumbler.enable = true; # Thumbnail support for images
  
}
