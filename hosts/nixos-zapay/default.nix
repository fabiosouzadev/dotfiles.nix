{ pkgs, ... }: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../modules/hardware/nix-zapay
    ../../modules/awsvpnclient.nix
  ];

  # Bootloader. (systemd)
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Bootloader. (grub)
  # boot.loader = {
  #   systemd-boot.enable = false;
  #   efi = {
  #     canTouchEfiVariables = true;
  #     efiSysMountPoint = "/boot";
  #   };
  #   grub = {
  #     enable = true;
  #     device = "nodev";
  #     efiSupport = true;
  #     useOSProber = true;
  #   };
  # };

  #boot.kernelPackages = pkgs.linuxPackages_5_19;
  #boot.kernelPackages = pkgs.linuxPackages_6_7_hardened;
  boot.kernelPackages = pkgs.linuxPackages_zen;
  #boot.kernelPackages = pkgs.linuxPackages_latest;
  #boot.kernelPackages = pkgs.linuxPackages_hardened;
  #boot.kernelPackages = pkgs.linuxPackages_hardened;
  boot.kernelModules = [ "rtl8821ce" "btintel" ];

  # Enable networking
  networking.networkmanager.enable = true;
  networking.hostName = "nixos-zapay"; # Define your hostname.
  networking.firewall.enable = false;

  services = {
    # for SSD/NVME
    fstrim.enable = true;
  };

  # environment.systemPackages = with pkgs; [
  #  linuxKernel.packages.linux_xanmod_stable.rtl8821ce
  #  linuxKernel.packages.linux_6_1.rtl8821ce
  #   linuxKernel.packages.linux_6_7.rtl8821ce
  #];

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
