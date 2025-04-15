{
  inputs,
  nixpkgs,
  home-manager,
  darwin,
  ...
}: let
  system = "x86_64-darwin";
  vars = {
    username = "fabiosouzadev";
    hostname = "macos";
    browser = "brave";
    terminal = "ghostty";
    desktop = "";
    wm = "aerospace";
    shell = "zsh";
    editor = "nvim";
    systemStateVersion = 4;
    stateVersion = "25.05";
  };
in {
  macbookintel = darwin.lib.darwinSystem {
    inherit system;
    specialArgs = {inherit inputs system vars;};
    modules = [
      ./configuration.nix
      home-manager.darwinModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = {inherit inputs system vars;};
        home-manager.users."${vars.username}" = {
          imports = [
            ./modules/home/shared/home-manager.nix
            ./modules/home/wm/aerospace
          ];
        };
        # NixOS system-wide home-manager configuration
        home-manager.sharedModules = [
          inputs.sops-nix.homeManagerModules.sops
        ];
        home-manager.backupFileExtension = "backup";
      }
      (import ../../overlays)
    ];
  };
}
