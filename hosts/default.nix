{ inputs, nixpkgs, nixpkgs-unstable, home-manager, ... }:
let
   system = "x86_64-linux";                                  # System Architecture

  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;                              # Allow Proprietary Software
  };

  unstable = import nixpkgs-unstable {
    inherit system;
    config.allowUnfree = true;
  };
in {

notezapay = nixpkgs.lib.nixosSystem {                               # Desktop Profile
    inherit system;
    specialArgs = {                                         # Pass Flake Variable
      inherit inputs system;
      host = {
        hostName = "notezapay";
      };
    };
    modules = [                                             # Modules Used
      ./notezapay
      ./configuration.nix

      home-manager.nixosModules.home-manager {              # Home-Manager Module
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.fabiosouzadev = import ./home;
      }
    ];
  };

}
