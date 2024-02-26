{  config, pkgs, defaultUser, defaultGit, ... }:

{
  
  home-manager.users.${defaultUser} = {
  home.packages = with pkgs; [
      nodePackages.pnpm
      nodePackages."bash-language-server"
      nodePackages."diagnostic-languageserver"
      nodePackages."dockerfile-language-server-nodejs"
      # nodePackages."pyright"
      # nodePackages."typescript"
      # nodePackages."typescript-language-server"
      # nodePackages."tailwindcss-language-server"
      # nodePackages."vscode-langservers-extracted"
      # nodePackages."vue-language-server"
      # nodePackages."yaml-language-server"
      # ocamlPackages.ocaml-lsp
      # ocamlPackages.ocamlformat
      # pkgs.cuelsp
      # pkgs.gopls
      # pkgs.haskell-language-server
      # pkgs.jsonnet-language-server
      pkgs.lua-language-server
      # pkgs.nil
      # pkgs.omnisharp-roslyn
      # pkgs.rust-analyzer
      # pkgs.terraform-ls
   ];

   
     programs.zsh = {
      shellAliases = {
	    "npm" = "${pkgs.nodePackages.pnpm}/bin/pnpm";
      };
     };
  };
}
