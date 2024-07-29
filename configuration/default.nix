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
      ./xfce.nix
      ../modules/fonts.nix
      ../modules/jetbrains.nix
      ../modules/polkit.nix
      ../modules/vscodium.nix
      # ../modules/neovim.nix
      # ./dns.nix
      ./quad9-dns.nix
    ]
    ++ lib.optionals hasVirtualisation [./virtualisation];
}
