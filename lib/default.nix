{
  inputs,
  pkgsOverride,
}: let
  defaultUsername = "fabiosouzadev";
  homeManagerShared = import ./shared/home-manager.nix;
  homeManagerNixos = import ./nixos/home-manager.nix;
  #homeManagerDarwin = import ./darwin/home-manager.nix;
in {
  #mkDarwim = {};
  mkNixos = {username ? defaultUsername}: {
    hostname,
    system,
    isDesktop,
    hasVirtualisation,
  }:
    inputs.nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {inherit inputs username hostname isDesktop hasVirtualisation;};
      # overlays = [inputs.neovim-flake.overlays.default];
      modules = [
        # pkgsOverride
        ../configuration
        ../hosts/${hostname}
        inputs.home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = {inherit inputs username isDesktop;};
          home-manager.users."${username}" = {
            imports = [
              homeManagerShared
              homeManagerNixos
            ];
          };
          # NixOS system-wide home-manager configuration
          home-manager.sharedModules = [
            inputs.sops-nix.homeManagerModules.sops
          ];
          home-manager.backupFileExtension = "backup";
        }
      ];
    };
}
