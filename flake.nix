{
  description = "NixOS configuration of fabiosouzadev [Refactored]";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    fabiosouzadev-nvim.url = "github:fabiosouzadev/neovim-nix";
    # fabiosouzadev-nvim-refactor2.url = "github:fabiosouzadev/neovim-nix?ref=refactor2";
    neovim-flake.url = "github:fabiosouzadev/neovim-flake.nix";

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
      url = "github:fabiosouzadev/rofi-themes";
      flake = false;
    };
    polybar-themes = {
      url = "github:fabiosouzadev/polybar-themes";
      flake = false;
    };
    wallpapers = {
      url = "github:fabiosouzadev/wallpapers";
      flake = false;
    };

    catppuccin-delta = {
      url = "github:catppuccin/delta";
      flake = false;
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    wezterm.url = "github:wez/wezterm?dir=nix";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    flake-parts,
    neovim-flake,
    ...
  }: let
    # mkDarwin = self.lib.mkDarwin {};
    mkNixos = self.lib.mkNixos {};
    pkgsOverride = inputs: {
      nixpkgs = {
        config.allowUnfree = true;
        overlays = [
          neovim-flake.overlays.default
        ];
      };
    };
  in
    flake-parts.lib.mkFlake {
      inherit inputs;
    } {
      flake = {
        lib = import ./lib {
          inherit inputs;
          inherit pkgsOverride;
        };

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
