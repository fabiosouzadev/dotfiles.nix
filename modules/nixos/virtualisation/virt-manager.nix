{
  pkgs,
  vars,
  ...
}: {
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      verbatimConfig = ''
        nvram = [ "${pkgs.OVMF}/FV/OVMF.fd:${pkgs.OVMF}/FV/OVMF_VARS.fd" ]
      '';
      swtpm.enable = true;
      runAsRoot = true;
    };
  };
  users.groups = {
    libvirtd.members = ["root" "${vars.username}"];
    kvm.members = ["root" "${vars.username}"];
  };

  environment = {
    systemPackages = with pkgs; [
      libvirt
      bridge-utils
      dnsmasq
      virt-manager # VM Interface
      virt-viewer # Remote VM
      qemu # Virtualizer
      qemu_kvm
      OVMF # UEFI Firmware
      gvfs # Shared Directory
      swtpm # TPM
      virglrenderer # Virtual OpenGL
    ];
  };

  home-manager.users.${vars.username} = {
    dconf.settings = {
      "org/virt-manager/virt-manager/connections" = {
        autoconnect = ["qemu:///system"];
        uris = ["qemu:///system"];
      };
    };
  };

  services.qemuGuest.enable = true;
  services.gvfs.enable = true;
}
