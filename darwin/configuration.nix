{
  config,
  lib,
  inputs,
  pkgs,
  system,
  vars,
  ...
}: {

users.users.${vars.username} = {
    name = vars.username;
    home = pkgs.lib.mkDefault "/Users/${vars.username}";
};

programs.${vars.shell}.enable = true;
environment = {
    shells =[pkgs.${vars.shell}] ;
    # loginShell = pkgs.${vars.shell};
    systemPath = [ "/opt/homebrew/bin" ];
    pathsToLink = [ "/Applications" ];
};

# Auto upgrade nix package and the daemon service.
# services.nix-daemon.enable = true;
nix.package = pkgs.nix;
nix.enable  = false;


# List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
environment.systemPackages = with pkgs; [
  coreutils
  inputs.neovim-flake.packages.${system}.default
];

# Set Git commit hash for darwin-version.
# system.configurationRevision = self.rev or self.dirtyRev or null;

# Used for backwards compatibility, please read the changelog before changing.
# $ darwin-rebuild changelog
system.stateVersion = vars.systemStateVersion;

# The platform the configuration will be used on.
nixpkgs.hostPlatform = system;
}