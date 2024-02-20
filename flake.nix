{
  description = "NixOS configuration of Fabio Souza (fabiosouzadev)";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
        url = "github:nix-community/home-manager";
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
