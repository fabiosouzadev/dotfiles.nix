{ nixpkgs, home-manager, ... }:
let 
  defaultGit = {
    extraConfig.github.user = defaultUser;
    userEmail = "fabiovanderlei.developer@gmail.com";
    userName = "Fabio Souza";
  };
  defaultUser =  "fabiosouzadev";
in
{
  "nix-zapay" = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
      modules = [
          ./nix-zapay
          ./configuration.nix { inherit defaultUser home-manager; }
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
          }
      ];
  };
  "vm" = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
      modules = [
          ./vm
          ./configuration.nix { inherit defaultUser home-manager; }
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
          }
      ];
  };
}