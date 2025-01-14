{pkgs, ...}: {
  hardware.enableAllFirmware = true;
  hardware.enableRedistributableFirmware = true;
  # bluetooth
  # List services that you want to enable:
  hardware.bluetooth = {
    enable = true;
    package = pkgs.bluez;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
      };
    };
  };

  services.blueman.enable = true;
  services.xserver.windowManager.i3.extraPackages = with pkgs; [
    bluetuith
  ];
}
