### Andriod virtualisation with LXC  on Wayland ###

# https://nixos.wiki/wiki/WayDroid
# https://waydro.id/
{  config, pkgs, defaultUser, defaultGit, ... }:

{
  virtualisation = {
    waydroid.enable = true;
  };

}
