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
      # ./xfce.nix
      ./gnome.nix
      ../modules/fonts.nix
      ../modules/jetbrains.nix
      ../modules/polkit.nix
      # ./quad9-dns.nix
      ./secrets/sops.nix
      ./secrets/zapay.nix
      ./neovim.nix
      ./aws-vpn.nix
    ]
    ++ lib.optionals hasVirtualisation [./virtualisation];
}
