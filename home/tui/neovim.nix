{
  pkgs,
  inputs,
  ...
}: let
  system = pkgs.system;
in {
  programs.neovim = inputs.fabiosouzadev-nvim.lib.mkHomeManager {inherit system;};
 /*  programs.neovim = {
    enable = true;
    package = pkgs.nvim-pkg;
  }; */
}

