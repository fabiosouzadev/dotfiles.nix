{
  lib,
  pkgs,
  vars,
  ...
}: {
  users.extraUsers.${vars.username}.extraGroups = ["audio"];
  # hardware.pulseaudio = {
  #   enable = true;
  #   support32Bit = true;
  #   package = pkgs.pulseaudioFull.override {jackaudioSupport = true;};
  #   extraConfig = "
  #         load-module module-switch-on-connect
  #         load-module module-combine-sink # if you want a combined channel where all output devices are part of
  #         load-module module-bluetooth-policy
  #         # load-module module-bluetooth-discover
  #         load-module module-bluez5-device
  #         load-module module-bluez5-discover
  #    ";
  # };

  services.pulseaudio = {
    enable = true;
    support32Bit = true;
    package = pkgs.pulseaudioFull.override {jackaudioSupport = true;};
    extraConfig = "
          load-module module-switch-on-connect
          load-module module-combine-sink # if you want a combined channel where all output devices are part of
          load-module module-bluetooth-policy
          # load-module module-bluetooth-discover
          load-module module-bluez5-device
          load-module module-bluez5-discover
     ";
  };

  nixpkgs.config.pulseaudio = true;
  services.pipewire = {
    enable = lib.mkForce false;
  };
  services.xserver.windowManager.i3.extraPackages = with pkgs; [
    pavucontrol
    playerctl
  ];
}
