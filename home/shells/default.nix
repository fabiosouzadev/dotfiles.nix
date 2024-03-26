{ config, pkgs, ... }:

{
  imports = [
    ./cli-tools.nix
    ./git.nix
    ./zsh.nix
    ./starship.nix
    ./gpg.nix
    ./tmux.nix
    ../editors/neovim.nix
  ];
}
