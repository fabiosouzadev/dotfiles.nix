{
  lib,
  inputs,
  nixpkgs,
  home-manager,
  nur,
  nixgl,
  username,
}: let
  pkgs = nixpkgs.packages.x86_64-linux;
in {
  mkHomeConfigurations = home-manager.lib.homeManagerConfiguration {
    extraSpecialArgs = {inherit inputs pkgs nur nixgl;};
    modules = [
      {
        home = {
          username = username;
          homeDirectory = pkgs.lib.mkDefault "/home/${username}/";
          stateVersion = "25.05";
        };

        # Let home Manager install and manage itself.
        programs.home-manager.enable = true;
      }
    ];
  };
}
