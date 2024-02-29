{
  description = "NixOS configuration of Fabio Souza (fabiosouzadev)";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
        url = "github:nix-community/home-manager";
        inputs.nixpkgs.follows = "nixpkgs";
    };
    myNvim = {
      url = "github:fabiosouzadev/nvim";
      flake = false;
    };

  };
  outputs = { 
    self,
    nixpkgs,
    home-manager, 
    myNvim,
    ... 
  }@inputs: {
    nixosConfigurations = (
      import ./hosts { inherit nixpkgs home-manager myNvim; }
    );
    #darwinConfigurations = ();
    #homeConfigurations = ();
  };
}
