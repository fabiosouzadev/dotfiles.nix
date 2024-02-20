{
  description = "NixOS configuration of Fabio Souza (fabiosouzadev)";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs.config.allowUnfree = true;
    home-manager = {
        url = "github:nix-community/home-manager";
        inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  
  outputs = { 
    self,
    nixpkgs,
    home-manager, 
    ... 
  }@inputs: {
    nixosConfigurations = (
      import ./hosts { inherit nixpkgs home-manager; }
    );
    #darwinConfigurations = ();
    #homeConfigurations = ();
  };
}
