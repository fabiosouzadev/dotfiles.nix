{ nixpkgs, defaultUser }: {
  # nix = {
  #   settings = {
  #     auto-optimise-store = true;
  #     builders-use-substitutes = true;
  #     experimental-features = [ "nix-command" "flakes" ];
  #     substituters = [
  #       "https://nix-community.cachix.org"
  #     ];
  #     trusted-public-keys = [
  #       "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
  #     ];
  #     trusted-users = [ defaultUser ];
  #     warn-dirty = false;
  #   };
  #   # do garbage collection weekly to keep disk usage low
  #   gc = {
  #     automatic = nixpkgs.lib.mkDefault true;
  #     dates = nixpkgs.lib.mkDefault "weekly";
  #     options = nixpkgs.lib.mkDefault "--delete-older-than 3d";
  #   };
  # };
  nixpkgs.config.allowUnfree = true;
  services.nix-daemon.enable = true;
}