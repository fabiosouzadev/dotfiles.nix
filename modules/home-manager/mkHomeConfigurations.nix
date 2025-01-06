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
