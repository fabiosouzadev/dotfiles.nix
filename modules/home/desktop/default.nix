{
  config,
  lib,
  pkgs,
  vars,
  ...
}: {
  imports = [
    ./common.nix
    ./cursor.nix
    # ./xdg.nix
  ];
}
