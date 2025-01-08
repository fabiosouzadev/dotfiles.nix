{
  pkgs,
  neovim-flake,
  ...
}: let
  system = pkgs.system;
in {
  programs.neovim = neovim-flake.${system}.nvim-hm;
}
