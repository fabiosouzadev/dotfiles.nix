{ user, home-manager }: 

{ config, pkgs, ... }: 

{
  imports = ( import ../modules/desktops);
  # imports = ( import ../modules/desktops ++
  #             import ../modules/editors ++
  #             import ../modules/hardware ++
  #             import ../modules/programs ++
  #             import ../modules/services ++
  #             import ../modules/shell ++
  #             import ../modules/theming );


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${user} = {
    isNormalUser = true;
    description = "Fabio Souza";
    extraGroups = [ "audio" "bluetooth" "networkmanager" "wheel" ];
    openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICZfQfANchWqcYPZiZtMQ7UByj/pReoe3HjYCpTkq4JT fabiovanderlei.developer@gmail.com"
    ];
  };
  home-manager.users.${user} = {       # Home-Manager Settings
    home = {
      stateVersion = "23.11";
    };
    programs = {
      home-manager.enable = true;
    };
  };

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_BR.UTF-8";
    LC_IDENTIFICATION = "pt_BR.UTF-8";
    LC_MEASUREMENT = "pt_BR.UTF-8";
    LC_MONETARY = "pt_BR.UTF-8";
    LC_NAME = "pt_BR.UTF-8";
    LC_NUMERIC = "pt_BR.UTF-8";
    LC_PAPER = "pt_BR.UTF-8";
    LC_TELEPHONE = "pt_BR.UTF-8";
    LC_TIME = "pt_BR.UTF-8";
    LC_CTYPE="en_US.utf8";
  };
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    curl
    git
    sysstat
    lm_sensors # for `sensors` command
    # minimal screen capture tool, used by i3 blur lock to take a screenshot
    # print screen key is also bound to this tool in i3 config
    scrot
    neofetch
    nnn # terminal file manager
    just
  ];

  # Configure keymap in X11
  services.xserver = {
    xkb = {
      layout = "us";
      variant = "alt-intl";
    };
  }; 
  # Configure console keymap
  console.keyMap = "dvorak";
}
