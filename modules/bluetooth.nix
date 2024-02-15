{ pkgs, lib, ... }:
{
  # bluetooth

  # hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  
  # List services that you want to enable:
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
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
}
