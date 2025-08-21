{
  description = "My Nix configs fabiosouzadev";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # MacOS Package Management
    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # NUR Community Packages
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
      # Requires "nur.nixosModules.nur" to be added to the host modules
    };

    ## My secrets ##
    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mysecrets = {
      url = "git+ssh://git@github.com/fabiosouzadev/nix-secrets.git?shallow=1";
      flake = false;
    };
    ## My inputs ##
    neovim-flake = {
      url = "github:fabiosouzadev/neovim-flake.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #customizations
    rofi-themes = {
      url = "github:fabiosouzadev/rofi-themes";
      flake = false;
    };
    polybar-themes = {
      url = "git+https://github.com/fabiosouzadev/polybar-themes.git?ref=master&rev=21f88b9214a25d67e97663c9e666b509b1b85106";
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

    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    nixos-hardware,
    home-manager,
    darwin,
    nur,
    sops-nix,
    mysecrets,
    neovim-flake,
    rofi-themes,
    polybar-themes,
    wallpapers,
    catppuccin-delta,
    hyprland,
    ...
  }: {
    darwinConfigurations = (
      import ./darwin {
        inherit (nixpkgs) lib;
        inherit inputs nixpkgs home-manager darwin;
      }
    );
    nixosConfigurations = (
      import ./nixos {
        inherit (nixpkgs) lib;
        inherit inputs nixpkgs home-manager darwin;
      }
    );
    homeConfigurations = let
      vars = {
        username = "fabiosouzadev";
        hostname = "nixos-zapay";
        browser = "brave";
        terminal = "wezterm";
        shell = "zsh";
        editor = "nvim";
        stateVersion = "25.05";
      };
    in {
      ubuntu = home-manager.lib.homeManagerConfiguration {
        extraSpecialArgs = {inherit inputs vars;};
        modules = [
          ./modules/shared/home-manager.nix
          ./modules/shared/nixpkgs.nix
        ];
      };
    };
    devShells = {};
  };
}
