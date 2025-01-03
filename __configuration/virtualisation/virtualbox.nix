
{ pkgs, username,... }:

{

  users.extraGroups.vboxusers.members = [ "${username}" ];
  virtualisation.virtualbox.host = {
	enable = true;
	enableExtensionPack = true;
  };
  virtualisation.virtualbox.guest = {
    	enable = true;
  	x11 = true;
  };
}
