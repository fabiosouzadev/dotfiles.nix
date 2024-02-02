{
    description = "NixOS configuration of Fabio Souza (fabiosouzadev)";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { self, nixpkgs, home-manager, ... }@inputs: {
        nixosConfigurations = {
            "notezapay" = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";

                modules = [
                    ./lib/nixos/configuration.nix
                    home-manager.nixosModules.home-manager
                    {
                        home-manager.useGlobalPkgs = true;
                        home-manager.useUserPackages = true;

                        # TODO replace ryan with your own username
                        home-manager.users.fabiosouzadev = import ./lib/nixos/home-manager.nix;

                    # Optionally, use home-manager.extraSpecialArgs to pass arguments to home.nix
                    }
                ];
            };
            "virt-manager" = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";

                modules = [
                    ./lib/nixos/configuration.nix
                    home-manager.nixosModules.home-manager
                    {
                        home-manager.useGlobalPkgs = true;
                        home-manager.useUserPackages = true;

                        # TODO replace ryan with your own username
                        home-manager.users.fabiosouzadev = import ./lib/nixos/home-manager.nix;

                    # Optionally, use home-manager.extraSpecialArgs to pass arguments to home.nix
                    }
                ];
            };
        };
    }
}
