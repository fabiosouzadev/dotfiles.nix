{ inputs, ... }:
let
pkgs = inputs.nixpkgs;
defaultUsername = "fabiosouzadev";
homeManagerShared = import ./shared/home-manager.nix;
homeManagerNixos  = import ./nixos/home-manager.nix;
#homeManagerDarwin = import ./darwin/home-manager.nix;
in {
  #mkDarwim = {};
 
  mkNixos = {
    username ? defaultUsername,
    isDesktop ? true,
    hasVirtualisation ? true,
  }: {hostname, system}:
   inputs.nixpkgs.lib.nixosSystem {
     inherit system;
     modules = [
      (import ../configuration { inherit username isDesktop hasVirtualisation; })
      (import ../hosts/${hostname})
      inputs.home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users."${username}" = { pkgs, ...}: {
          imports = [
            (homeManagerShared {inherit username;})
            (homeManagerNixos {inherit isDesktop;})
          ];
        };
      }
     ];
   };
}
