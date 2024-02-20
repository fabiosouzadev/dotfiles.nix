{
  description = "NixOS configuration of Fabio Souza (fabiosouzadev)";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
	  nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
	  home-manager-unstable = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };
  
  outputs = inputs @ { 
    self, 
    nixpkgs, 
    nixpkgs-unstable,
    home-manager, 
    ... 
  }: {
    nixosConfigurations = (
      import ./hosts { inherit nixpkgs home-manager; }
    );
    #darwinConfigurations = ();
    #homeConfigurations = ();
  };
}
