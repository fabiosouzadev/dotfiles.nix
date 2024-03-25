
{  pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    withRuby = true;
    withPython3 = true;
    withNodeJs = true;
    plugins = with pkgs.vimPlugins; [
      # search all the plugins using https://search.nixos.org/packages
      vim-tmux-navigator
      telescope-fzf-native-nvim
    ];
    extraConfig = ''
    set number relativenumber
    set clipboard+=unnamedplus
    '';
  };
}
