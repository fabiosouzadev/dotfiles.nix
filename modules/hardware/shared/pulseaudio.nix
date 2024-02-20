
{ pkgs, lib, ... }: 
{
  hardware.pulseaudio = {
    enable = true;
    support32Bit = true;
    package = pkgs.pulseaudioFull;
    #configFile = pkgs.writeText "default.pa" ''
    #	load-module module-bluetooth-policy
    # 	load-module module-bluetooth-discover
    #	## module fails to load with 
    #	##   module-bluez5-device.c: Failed to get device path from module arguments
    #	##   module.c: Failed to load module "module-bluez5-device" (argument: ""): initialization failed.
    #	# load-module module-bluez5-device
    #	# load-module module-bluez5-discover
    #	'';
    daemon.config = {
         default-sample-rate = 48000;
         default-fragments = 8;
         default-fragment-size-msec = 10;
        };
     extraConfig = "
          load-module module-switch-on-connect
          #load-module module-combine-sink # if you want a combined channel where all output devices are part of
          load-module module-bluetooth-policy
          load-module module-bluetooth-discover
          load-module module-bluez5-device
          load-module module-bluez5-discover
        ";
  };
  
  nixpkgs.config.pulseaudio = true;

  services.xserver.windowManager.i3.extraPackages = with pkgs; [
 	  pavucontrol
 	  playerctl
 ];
} 
