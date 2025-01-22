{vars, ...}: {
  users.extraGroups.vboxusers.members = ["${vars.username}"];
  virtualisation.virtualbox.host = {
    enable = true;
    enableExtensionPack = true;
  };
  virtualisation.virtualbox.guest = {
    enable = true;
    x11 = true;
  };
}
