{pkgs, nixpkgs, home-manager}:
let 
  defaultUser = {
    user = "fabiosouzadev";
    defaultGit = {
      userEmail = "fabiovanderlei.developer@gmail.com";
      userName = "Fabio Souza";
    }
  };
in
{
  "nix-zapay" = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
      modules = [
          ./hosts/notezapay
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
          ./configuration.nix { inherit pkgs defaultUser home-manager; }
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
          }
      ];
  };
}