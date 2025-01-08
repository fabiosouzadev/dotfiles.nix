{
  pkgs,
  neovim-flake,
  ...
}: {
  home.packages = [
    neovim-flake.packages.${pkgs.system}.default
  ];
}
