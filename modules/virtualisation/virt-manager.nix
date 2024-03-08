{  config, pkgs, defaultUser, defaultGit, ... }:

{
  virtualisation.libvirtd.enable = true;
  users.users.${defaultUser}.extraGroups = [ "libvirtd" ];
 
  environment = {
    systemPackages = with pkgs; [
      virt-manager    # VM Interface
      virt-viewer     # Remote VM
      qemu            # Virtualizer
      qemu_kvm
    ];
  };

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
