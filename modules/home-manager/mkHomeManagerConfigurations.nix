{
  nixpkgs,
  home-manager,
}: let
  system = "x86_64-linux";
  pkgs = nixpkgs.legacyPackages.${system};
in {
  mkHomeManagerConfiguration = {
    inputs,
    nur,
    nixgl,
    username,
  }:
    home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = {inherit inputs pkgs nur nixgl;};
      modules = [
        ./desktops/terminals
        {
          home = {
            username = username;
            homeDirectory = pkgs.lib.mkDefault "/home/${username}/";
            stateVersion = "24.11";
          };
          nix.settings.experimental-features = ["nix-command" "flakes"];
          # Let home Manager install and manage itself.
          programs.home-manager.enable = true;
        }
      ];
    };
}
