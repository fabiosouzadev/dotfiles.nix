{ nixpkgs, home-manager, ... }:
let
  defaultUser =  "fabiosouzadev";
  defaultGit = {
    extraConfig.github.user = defaultUser;
    userEmail = "fabiovanderlei.developer@gmail.com";
    userName = "Fabio Souza";
  };
  system = "x86_64-linux";
  pkgs = import nixpkgs {
    inherit system;
    config = {
    allowUnfree = true;
    };
  };
in
{
  "nix-zapay" = nixpkgs.lib.nixosSystem {
      specialArgs = { 
          inherit system;
          inherit defaultUser;
          inherit defaultGit;
        };
      modules = [
          ./nix-zapay
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
          }
      ];
  };
  "vm" = nixpkgs.lib.nixosSystem {
      specialArgs = { 
          inherit system;
          inherit defaultUser;
          inherit defaultGit;
        };
      modules = [
          ./vm
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
          }
      ];
  };
}