{  config, pkgs, ... }:
 
{
  # TODO please change the username & home direcotry to your own
  home.username = "fabiosouzadev";
  home.homeDirectory = "/home/fabiosouzadev";
  
  
  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    slack
    brave
    authy
    bitwarden
  ];

  home.file."/.config/wallpapers" = {
   source = ../../configs/wallpapers;
   recursive = true;
  };
  
  home.file."/.config/i3" = {
   source = ../../configs/i3;
   recursive = true;
  };
  
  home.file."/.screenlayout/dual_intel_iris_xe.sh".source = ../../configs/monitors/xrand/dual_intel_iris_xe.sh;
  
  home.file."/.config/picom" = {
   source = ../../configs/picom;
   recursive = true;
  };
  
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

  
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  # basic configuration of git, please change to your own
  programs.git = {
    enable = true;
    userName = "Fabio Souza";
    userEmail = "fabiovanderlei.developer@gmail.com";
  };

#  programs.autorandr = {
#    enable = true;
#    profiles = {
#      "both" = {
#      	fingerprint = {
#	  DP-1   = "";
#	  HDMI-1 = "";
#	};
#	config = {
#	  DP-1 = {
#           dpi = 100;
#           enable = true;
#           mode = "1920x1080";
#           position = "0x0";
#           rate = "60.00";
#          };
#	  HDMI-1 = {
#           enable = true;
#           primary = true;
#           #position = "0x0";
#           mode = "1920x1080";
#           #rate = "60.00";
#           #scale = {
#           #x = 2.0;
#           #y = 2.0;
#           #};
#          };
#	};
#      };
#      "note" = {
#      };
#    };
#  };

  # starship - an customizable prompt for any shell
  # programs.starship = {
  #   enable = true;
  #   enableBashIntegration = true;
  #   enableZshIntegration = true;
  #   enableNushellIntegration = true;
  #   # custom settings
  #   settings = {
  #     add_newline = false;
  #     aws.disabled = true;
  #     gcloud.disabled = true;
  #     line_break.disabled = true;
  #   };
  # };

  # alacritty - a cross-platform, GPU-accelerated terminal emulator
  programs.alacritty = {
    enable = true;
    # custom settings
    settings = {
      env.TERM = "xterm-256color";
      font = {
        size = 12;
      };
      scrolling.multiplier = 5;
      selection.save_to_clipboard = true;
    };
  };

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
