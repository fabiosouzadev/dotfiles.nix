{
  description = "Nix configurations of fabiosouzadev";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    #nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05"; # Unstable Nix Packages
    nixos-hardware.url = "github:nixos/nixos-hardware/master"; # Hardware Specific Configurations

    # MacOS Package Management
    darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # User Environment Manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # NUR Community Packages
    nur = {
      url = "github:nix-community/NUR";
      # Requires "nur.nixosModules.nur" to be added to the host modules
    };

    # Fixes OpenGL With Other Distros.
    nixgl = {
      url = "github:guibou/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    nixos-hardware,
    darwin,
    home-manager,
    nur,
    nixgl,
  }: let
    username = "fabiosouzadev";
    mkHomeConfigurations = import ./modules/home-manager/mkHomeConfigurations;
  in {
    nixosConfigurations = {};
    darwinConfigurations = {};

    homeConfigurations = {
      ubuntu = mkHomeConfigurations {
        inherit (nixpkgs) lib;
        inherit inputs nixpkgs home-manager nur nixgl username;
      };
    };

    packages.x86_64-linux.hello = nixpkgs.legacyPackages.x86_64-linux.hello;

    packages.x86_64-linux.default = self.packages.x86_64-linux.hello;
  };
}
