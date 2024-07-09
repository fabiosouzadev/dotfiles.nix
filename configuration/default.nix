{
  lib,
  hasVirtualisation,
  ...
}: {
  imports =
    [
      ./user.nix
      ./nix.nix
      ./system-packages.nix
      ./localization.nix
      ./keymap.nix
      ./xorg.nix
      ../modules/fonts.nix
      ../modules/jetbrains.nix
      ../modules/polkit.nix
      ../modules/vscodium.nix
      # ../modules/neovim.nix
    ]
    ++ lib.optionals hasVirtualisation [./virtualisation];
}
