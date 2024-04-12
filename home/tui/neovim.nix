{ pkgs, inputs, ... }: let
 system = pkgs.system;
in {
 programs.neovim = inputs.fabiosouzadev-neovim.lib.mkHomeManager {inherit system;};
} 