{pkgs, username, isDesktop, hasVirtualisation, ...}:
{
  imports = [
    (import ./user.nix {inherit pkgs username isDesktop hasVirtualisation; })
    (import ./nix.nix {inherit pkgs username; })
    ./system-packages.nix
    ./localization.nix
    ./keymap.nix
    ../modules/fonts.nix
    (import ../modules/i3.nix { inherit pkgs username; })
    ../modules/jetbrains.nix
    ../modules/polkit.nix
    ../modules/vscodium.nix
  ];
}
