{
  description = "NixOS configuration of Fabio Souza (fabiosouzadev)";
  inputs = {
	  nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  
  outputs = inputs @ { 
    self,
    pkgs,
    nixpkgs,
    home-manager, 
    ... 
  }: {
    nixosConfigurations = (
      import ./hosts { inherit pkgs nixpkgs home-manager; }
    );
    #darwinConfigurations = ();
    #homeConfigurations = ();
  };
}
