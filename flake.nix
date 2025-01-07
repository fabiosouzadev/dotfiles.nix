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
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    nixos-hardware,
    darwin,
    home-manager,
    nur,
    nixgl,
    rofi-themes,
    polybar-themes,
    wallpapers,
    catppuccin-delta,
  }: let
    username = "fabiosouzadev";
    pkgs = import nixpkgs {
      system = "x86_64-linux";
      overlays = [nixgl.overlay];
      config.allowUnfree = true;
    };
    mkHomeManagerConfiguration = inputs: nur: nixgl: rofi-themes: polybar-themes: wallpapers: catppuccin-delta: username:
      home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {inherit inputs pkgs nur nixgl rofi-themes polybar-themes wallpapers catppuccin-delta;};
        modules = [
          ./modules/home-manager/desktops
          ./modules/home-manager/gui
          ./modules/home-manager/editors
          ./modules/home-manager/tui
          {
            home = {
              username = username;
              homeDirectory = pkgs.lib.mkDefault "/home/${username}/";
              stateVersion = "24.11";
              # Other local things
              packages = with pkgs; [
                nixgl.nixGLIntel
              ];
            };
            nix = {
              settings = {
                auto-optimise-store = true;
              };
              package = pkgs.nixVersions.stable;
              registry.nixpkgs.flake = inputs.nixpkgs;
              settings.experimental-features = ["nix-command" "flakes"];
            };
            nixpkgs.config.allowUnfree = true;
            # Let home Manager install and manage itself.
            programs.home-manager.enable = true;
          }
        ];
      };
  in {
    nixosConfigurations = {};
    darwinConfigurations = {};

    homeConfigurations = {
      ubuntu = mkHomeManagerConfiguration {
        # inherit (nixpkgs) lib;
        inherit inputs nur nixgl username;
      };
      rhino = mkHomeManagerConfiguration inputs nur nixgl rofi-themes polybar-themes wallpapers catppuccin-delta username;
    };

    packages.x86_64-linux.hello = nixpkgs.legacyPackages.x86_64-linux.hello;

    packages.x86_64-linux.default = self.packages.x86_64-linux.hello;
  };
}
