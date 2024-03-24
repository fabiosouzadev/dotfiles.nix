{username, isDesktop, hasVirtualisation} : { pkgs,  ... }:
{
  imports = [
    (import ./user.nix {inherit pkgs username isDesktop hasVirtualisation; })
    (import ./nix.nix {inherit pkgs username; })
    ./system-packages.nix
    ./localization.nix
    ./keymap.nix
  ];
}
