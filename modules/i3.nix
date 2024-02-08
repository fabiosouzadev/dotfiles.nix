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
        #picom         # transparency and shadows
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
        polybar
        haskellPackages.greenclip
        # polkit_gnome
        # pulseaudioFull
        # networkmanagerapplet
        # gnome.gnome-keyring
        dmenu
     ];
    };

  };

  environment.etc."xdg/i3/config".text = import ../configs/i3/i3-config.nix;
  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.tumbler.enable = true; # Thumbnail support for images

  services.picom = {
    enable = true;
    package = pkgs.picom.overrideAttrs (_: {
      src = pkgs.fetchFromGitHub {
        repo = "picom";
        owner = "ibhagwan";
        rev = "44b4970f70d6b23759a61a2b94d9bfb4351b41b1";
        sha256 = "0iff4bwpc00xbjad0m000midslgx12aihs33mdvfckr75r114ylh";
      };
    });

    activeOpacity = "1.0";
    inactiveOpacity = "0.9";
    fade = true;

    opacityRule = [
      "80:class_g     = 'Bar'",             # lemonbar
      "100:class_g    = 'slop'",            # maim
      "100:class_g    = 'XTerm'",
      "100:class_g    = 'URxvt'",
      "100:class_g    = 'kitty'",
      # "100:class_g    = 'Alacritty'",
      "80:class_g     = 'Polybar'",
      "100:class_g    = 'code-oss'",
      "100:class_g    = 'Meld'",
      "70:class_g     = 'TelegramDesktop'",
      "90:class_g     = 'Joplin'",
      "100:class_g    = 'firefox'",
      "100:class_g    = 'Thunderbird'",
      "90:class_g     = 'VSCodium'",
      "90:class_g     = 'jetbrains-*'",
      "90:class_g     = 'Xfce4-terminal'",
      "90:class_g     = 'Alacritty'"
    ];
  };
  
}
