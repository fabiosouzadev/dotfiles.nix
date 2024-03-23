{inputs}: 
let
defaultUsername = "fabiosouzadev";
homeManagerShared = import ./shared/home-manager.nix;
homeManagerNixos  = import ./nixos/home-manager.nix;
#homeManagerDarwin = import ./darwin/home-manager.nix;
in {
  #mkDarwim = {};
 
  mkNixos = {
    username ? defaultUsername,
    isDesktop ? true,
  }: {system}:
   inputs.nixpkgs.lib.nixosSystem {
     inherit system;
     modules = [
     inputs.home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users."${username}" = {config,pkgs, ...}: {
            imports = [
              (homeManagerShared {inherit config pkgs username;})
              (homeManagerNixos {inherit config pkgs isDesktop;})
            ];
          };
        }
     ];
   };
}
