{ pkgs, defaultUser }: 
{
  nix = {
    settings = {
      auto-optimise-store = true;
      builders-use-substitutes = true;
      experimental-features = [ "nix-command" "flakes" ];
      substituters = [
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
      trusted-users = [ "fabiosouzadev" ];
      warn-dirty = false;
    };
    # do garbage collection weekly to keep disk usage low
    gc = {
      automatic = pkgs.lib.mkDefault true;
      dates = pkgs.lib.mkDefault "weekly";
      options = pkgs.lib.mkDefault "--delete-older-than 3d";
    };
  };
  nixpkgs.config.allowUnfree = true;
  services.nix-daemon.enable = true;
}

