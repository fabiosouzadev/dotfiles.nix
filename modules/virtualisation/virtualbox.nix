
{  config, pkgs, defaultUser, defaultGit, ... }:

{

  users.extraGroups.vboxusers.members = [ "${defaultUser}" ];
  virtualisation.virtualbox.host = {
	enable = true;
	enableExtensionPack = true;
  };
  virtualisation.virtualbox.guest = {
    	enable = true;
  	x11 = true;
  };
}
