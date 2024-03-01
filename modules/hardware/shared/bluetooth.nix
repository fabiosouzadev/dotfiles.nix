{ pkgs, lib, ... }:
{
  hardware.enableAllFirmware = true;
  # bluetooth
  # List services that you want to enable:
  hardware.bluetooth = {
    enable = true;
    package = pkgs.bluez;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
      };
      Policy = {
        AutoEnable = "true";
      };
    };
  };
 
  services.blueman.enable = true;
  services.xserver.windowManager.i3.extraPackages = with pkgs; [
    bluetuith	
 ];

}
