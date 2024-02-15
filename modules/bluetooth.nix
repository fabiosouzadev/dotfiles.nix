{ pkgs, lib, ... }:
{
# bluetooth
  hardware.bluetooth.enable = true;
  # List services that you want to enable:
  hardware.bluetooth = {
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
        Name = "Hello";
        ControllerMode = "dual";
        FastConnectable = "true";
        Experimental = "true";
      };
      Policy = {
        AutoEnable = "true";
      };
    };
  };
  services.blueman.enable = true;
}