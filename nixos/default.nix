{
  inputs,
  nixpkgs,
  home-manager,
  ...
}: let
  system = "x86_64-linux";
  vars = {
    username = "fabiosouzadev";
    hostname = "nixos-zapay";
    browser = "brave";
    terminal = "wezterm";
    desktop = "xfce";
    wm = "i3";
    # desktop = "gnome";
    # wm = "";
    shell = "zsh";
    editor = "nvim";
    stateVersion = "25.05";
  };
in {
  work = nixpkgs.lib.nixosSystem {
    inherit system;
    specialArgs = {inherit inputs system vars;};
    modules = [
      {config.${vars.desktop}.enable = true;}
      ./hosts/dell-inspirion-3520
      ../modules/nixos/common/system-packages.nix
      ../modules/nixos/common/fonts.nix
      ../modules/nixos/common/nixpkgs.nix
      ../modules/nixos/common/xorg.nix
      ../modules/nixos/secrets/sops.nix
      ../modules/nixos/secrets/zapay.nix
      ../modules/nixos/desktop
      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = {inherit inputs system vars;};
        home-manager.users."${vars.username}" = {
          # TODO please change the username & home directory to your own
          home.username = vars.username;
          home.homeDirectory = nixpkgs.lib.mkDefault "/home/${vars.username}";
          imports =
            [
              ../modules/home/instivo
              ../modules/home/shared/home-manager.nix
              ../modules/home/shared/common.nix
              ../modules/home/browsers
              ../modules/home/shared/xdg.nix
            ]
            ++ (nixpkgs.lib.optionals (vars.desktop == "xfce" && vars.wm == "i3") [../modules/home/wm/i3]);
        };
        # NixOS system-wide home-manager configuration
        home-manager.sharedModules = [
          inputs.sops-nix.homeManagerModules.sops
        ];
        home-manager.backupFileExtension = "backup";
      }
      (import ../overlays)
    ];
  };
}
