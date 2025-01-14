{
  description = "My Nix configs fabiosouzadev";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # MacOS Package Management
    darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # NUR Community Packages
    nur = {
      url = "github:nix-community/NUR";
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
    neovim-flake.url = "github:fabiosouzadev/neovim-flake.nix";

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
    home-manager,
  }: {
    darwinConfigurations = {};
    nixosConfigurations = {
      test = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs;};
      };
    };
    homeConfigurations = {
      ubuntu = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {inherit inputs;};
        modules = [
          ./modules/home-manager.nix
        ];
      };
    };
    devShells = {};
  };
}
