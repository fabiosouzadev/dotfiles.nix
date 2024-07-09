{pkgs, ...}: {
  imports = [
    ./common.nix
    ../gui
    ./browsers.nix
    ./spotify.nix
    ./terminals
  ];
}
