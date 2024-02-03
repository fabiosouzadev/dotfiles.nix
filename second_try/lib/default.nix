let
   defaultGit = {
    extraConfig.github.user = defaultUsername;
    userEmail = "fabiovanderlei.developer@gmail.com";
    userName = "Fabio Souza";
  };
  defaultUsername = "fabiosouzadev";
  homeManagerNixos = import ./nixos/home-manager.nix { inherit inputs; };
  homeManagerShared = import ./shared/home-manager.nix { inherit inputs; };
in 
{

}
