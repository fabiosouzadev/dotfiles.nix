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
    nix-darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # NUR Community Packages
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
      # Requires "nur.nixosModules.nur" to be added to the host modules
    };

    #zen-browser
    zen-browser.url = "github:MarceColl/zen-browser-flake";

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
    nix-darwin,
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
    darwinConfigurations = let
      system = "x86_64-darwin";
      vars = {
        username = "fabiosouzadev";
        hostname = "nix-macos";
        browser = "brave";
        terminal = "ghostty";
        desktop = "";
        wm = "aerospace";
        shell = "zsh";
        editor = "nvim";
        systemStateVersion = 4;
        stateVersion = "25.05";
      };
    in {
      macos = nix-darwin.lib.darwinSystem {
        inherit system;
        specialArgs = {inherit inputs system vars;};
        modules = [
          ./modules/darwin
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = {inherit inputs system vars;};
            home-manager.users."${vars.username}" = {
              imports = [
                ./modules/home/shared/home-manager.nix
                ./modules/home/wm/aerospace
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
    nixosConfigurations = let
      system = "x86_64-linux";
      vars = {
        username = "fabiosouzadev";
        hostname = "nixos-zapay";
        browser = "brave";
        terminal = "wezterm";
        desktop = "xfce";
        wm = "i3";
        # desktop = "gnome";
        # wm = "";
        shell = "zsh";
        editor = "nvim";
        stateVersion = "25.05";
      };
    in {
      work = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {inherit inputs system vars;};
        modules = [
          {config.${vars.desktop}.enable = true;}
          ./hosts/dell-inspirion-3520
          ./modules/nixos/shared/system-packages.nix
          ./modules/nixos/shared/fonts.nix
          ./modules/nixos/shared/nixpkgs.nix
          ./modules/nixos/shared/xorg.nix
          ./modules/nixos/secrets/sops.nix
          ./modules/nixos/secrets/zapay.nix
          ./modules/nixos/desktop
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = {inherit inputs system vars;};
            home-manager.users."${vars.username}" = {
              # TODO please change the username & home directory to your own
              home.username = vars.username;
              home.homeDirectory = nixpkgs.lib.mkDefault "/home/${vars.username}";
              imports = [
                ./modules/home/shared/home-manager.nix
                ./modules/home/shared/common.nix
                ./modules/home/browsers
                ./modules/home/shared/xdg.nix
              ]
              ++ (nixpkgs.lib.optionals (vars.desktop == "xfce" && vars.wm == "i3") [../wm/i3]);
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
