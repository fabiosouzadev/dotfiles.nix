{...}: {
  imports = [
    # Include the results of the hardware scan.
    ./configuration.nix
    ./kernel.nix
    ./fstrim.nix
    ./networking.nix
    ../../modules/hardware/nix-zapay
    ../../modules/awsvpnclient.nix
  ];
}
