{
  inputs,
  pkgs,
  ...
}: let
  system = pkgs.system;
in {
  environment.systemPackages = [
    inputs.neovim-flake.packages.${system}.default
  ];
}
