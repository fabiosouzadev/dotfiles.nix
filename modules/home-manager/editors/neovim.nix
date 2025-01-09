{
  pkgs,
  neovim-flake,
  ...
}: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    package = neovim-flake.packages.${pkgs.system}.default;
  };
}
