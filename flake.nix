{
  description = "NixOS configuration of fabiosouzadev [Refactored]";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    awsvpnclient.url = "github:ymatsiuk/awsvpnclient";
    fabiosouzadev-nvim.url = "github:fabiosouzadev/neovim-nix";

    # Secrets
    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mysecrets = {
      url = "git+ssh://git@github.com/fabiosouzadev/nix-secrets.git?shallow=1";
      flake = false;
    };

    #customizations
    rofi-themes = {
      url = "git+ssh://git@github.com/fabiosouzadev/rofi-themes.git?shallow=1";
      flake = false;
    };
    polybar-themes = {
      url = "git+ssh://git@github.com/fabiosouzadev/polybar-themes.git?shallow=1";
      flake = false;
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    flake-parts,
    ...
  }: let
    # mkDarwin = self.lib.mkDarwin {};
    mkNixos = self.lib.mkNixos {};
  in
    flake-parts.lib.mkFlake {inherit inputs;} {
      flake = {
        lib = import ./lib {inherit inputs;};

        nixosConfigurations = {
          nixos-zapay = mkNixos {
            hostname = "nixos-zapay";
            system = "x86_64-linux";
            isDesktop = true;
            hasVirtualisation = true;
          };
          vm = mkNixos {
            hostname = "vm";
            system = "x86_64-linux";
            isDesktop = true;
            hasVirtualisation = false;
          };
        };

        #darwinConfigurations = {};
      };
      systems = ["aarch64-darwin" "aarch64-linux" "x86_64-darwin" "x86_64-linux"];
      perSystem = {
        config,
        self',
        inputs',
        pkgs,
        system,
        ...
      }: {
        devShells = {
          default = pkgs.mkShell {
            nativeBuildInputs = with pkgs; [just];
          };
        };
        formatter = pkgs.nixpkgs-fmt;
      };

      #packages.x86_64-linux.hello = nixpkgs.legacyPackages.x86_64-linux.hello;

      #packages.x86_64-linux.default = self.packages.x86_64-linux.hello;
    };
}
