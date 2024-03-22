{
  description = "NixOS configuration of Fabio Souza (fabiosouzadev)";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
        url = "github:nix-community/home-manager";
        inputs.nixpkgs.follows = "nixpkgs";
    };
    myNvim = {
      url = "github:ALT-F4-LLC/thealtf4stream.nvim";
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
