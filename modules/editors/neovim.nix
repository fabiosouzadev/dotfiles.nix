
{  config, pkgs, defaultUser, defaultGit, myNvim, ... }:

{
  
  home-manager.users.${defaultUser} = {
   # xdg.configFile = {
   #   # astronvim's config
   #   "nvim" = {
   #     source = myNvim;
   #     force = true;
   #   };
   # };


   programs.neovim = {
     enable = true;
     defaultEditor = true;
     viAlias = true;
     vimAlias = true;
     plugins = with pkgs; [
        # search all the plugins using https://search.nixos.org/packages
        vimPlugins.telescope-fzf-native-nvim
      ];
   };
 };
}
