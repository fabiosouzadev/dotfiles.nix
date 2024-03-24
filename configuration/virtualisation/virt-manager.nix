{  pkgs, username, ... }:

{
  virtualisation.libvirtd.enable = true;
  users.users.${username}.extraGroups = [ "libvirtd" ];
 
  environment = {
    systemPackages = with pkgs; [
      virt-manager    # VM Interface
      virt-viewer     # Remote VM
      qemu            # Virtualizer
      qemu_kvm
    ];
  };

  home-manager.users.${username} = {
    dconf.settings = {
      "org/virt-manager/virt-manager/connections" = {
         autoconnect = ["qemu:///system"];
         uris = ["qemu:///system"];
      };
    };
  };

  services.qemuGuest.enable = true;
}
