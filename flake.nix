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
    ...
  }: {
    darwinConfigurations = {};
    nixosConfigurations = let
      username = "fabiosouzadev";
      hostname = "nixos-zapay";
      browser = "brave";
      terminal = "wezterm";
      de = "xfce";
      shell = "zsh";
      editor = "nvim";
      stateVersion = "25.05";
    in {
      work = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs username hostname shell stateVersion;};
        modules = [
          ./hosts/dell-inspirion-3520
          ./modules/shared/fonts.nix
          ./modules/shared/nixpkgs.nix
          ./modules/secrets/sops.nix
          ./modules/secrets/zapay.nix
          ./modules/de/xfce.nix
          ./modules/shared/xorg.nix
          ./modules/shared/neovim.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = {inherit inputs username hostname stateVersion;};
            home-manager.users."${username}" = {
              imports = [
                ./modules/shared/home-manager.nix
              ];
            };
            # NixOS system-wide home-manager configuration
            home-manager.sharedModules = [
              inputs.sops-nix.homeManagerModules.sops
            ];
            home-manager.backupFileExtension = "backup";
          }
          (import ./overlays)
        ];
      };
    };
    homeConfigurations = let
      username = "fabiosouzadev";
      hostname = "nixos-zapay";
      browser = "brave";
      terminal = "wezterm";
      de = "xfce";
      shell = "zsh";
      editor = "nvim";
      stateVersion = "25.05";
    in {
      ubuntu = home-manager.lib.homeManagerConfiguration {
        extraSpecialArgs = {inherit inputs nixpkgs username hostname stateVersion;};
        modules = [
          ./modules/shared/home-manager.nix
          ./modules/shared/nixpkgs.nix
        ];
      };
    };
    devShells = {};
  };
}
