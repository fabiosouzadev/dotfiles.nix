{  config, pkgs, defaultUser, defaultGit, ... }:

{
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
  users.users.${defaultUser}.extraGroups = [ "libvirtd" ];

  users.groups.docker.members = [ "${defaultUser}" ];

  home-manager.users.${defaultUser} = {
  	dconf.settings = {
    		"org/virt-manager/virt-manager/connections" = {
      		autoconnect = ["qemu:///system"];
      		uris = ["qemu:///system"];
    };
  };

  };

  services.qemuGuest.enable = true;
}
