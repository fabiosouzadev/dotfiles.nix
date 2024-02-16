
{ config, pkgs, ... }:

{
  imports =
    [ 
      ../../modules/system.nix
      ../../modules/bluetooth.nix
      ../../modules/pulseaudio.nix
      ../../modules/desktop.nix
      ../../modules/i3.nix
      ../../modules/polkit.nix
      ../../modules/gnome-keyring.nix
      ../../modules/zsh.nix
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  #boot.loader.grub= { 
  #    enable = true;
  #    device = "/dev/vda";
  #    useOSProber = true;
  #};

  # Bootloader.
  boot.loader = { 
	systemd-boot = {
		enable = true;
        }; 
        efi = {
		canTouchEfiVariables = true;
       };
  };

  boot.loader.grub.device = "nodev";
  #boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.extraModulePackages = [ config.boot.kernelPackages.rtl8821ce ];
  
  # Enable networking
  networking.networkmanager.enable = true;
  networking.hostName = "notezapay"; # Define your hostname.
  
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
