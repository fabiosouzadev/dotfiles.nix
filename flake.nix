{
  description = "NixOS configuration of fabiosouzadev [Refactored]";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    home-manager = {
        url = "github:nix-community/home-manager";
        inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, flake-parts, ... }:
  let
    mkDarwin = self.lib.mkDarwin {};
    mkNixos = self.lib.mkNixos {};
  in
    flake-parts.lib.mkFlake { inherit inputs; } {
      flake = {

        lib = import ./lib {inherit inputs nixpkgs;};

        nixosConfigurations = {
          nix-zapay = mkNixos {hostname = "nix-zapay"; system = "x86_64-linux"; isDesktop = true; hasVirtualisation = true;};
          vm = mkNixos {hostname = "vm"; system = "x86_64-linux"; isDesktop = true; hasVirtualisation = false;};
        };

        #darwinConfigurations = {};
      };
      systems = ["aarch64-darwin" "aarch64-linux" "x86_64-darwin" "x86_64-linux"];
      perSystem = { config, pkgs, ... }: {
      	devShells = {
          default = pkgs.mkShell {
            nativeBuildInputs = with pkgs; [ just cowsay ];
          };
        };
	      formatter = pkgs.alejandra;
      }; 

    #packages.x86_64-linux.hello = nixpkgs.legacyPackages.x86_64-linux.hello;
    
    #packages.x86_64-linux.default = self.packages.x86_64-linux.hello;
  };
}
