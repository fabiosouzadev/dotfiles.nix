{ config, pkgs, inputs, system,  ... }:

{
  imports = [
    ./cli-tools.nix
    ./git.nix
    ./zsh.nix
    ./starship.nix
    ./gpg.nix
    ./tmux.nix
    ./neovim.nix
  ];
}
