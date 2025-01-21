{inputs, ...}: {
  imports = [
    # Include the results of the hardware scan.
    inputs.nixos-hardware.nixosModules.dell-inspiron-5509
    ./configuration.nix
  ];
}
