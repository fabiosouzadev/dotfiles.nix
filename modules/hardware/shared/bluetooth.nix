{ pkgs, lib, ... }:
{
  security.rtkit.enable = true;
  hardware.enableAllFirmware = true;
  # bluetooth
  # List services that you want to enable:
  hardware.bluetooth = {
    enable = true;
    package = pkgs.bluez;
    hsphfpd.enable = true;
    input.General.ClassicBondedOnly = false;
    powerOnBoot = true;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
        Name = "BT-CONFIG";
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

  systemd.user.services.mpris-proxy = {
    description = "Mpris proxy";
    after = [ "network.target" "sound.target" ];
    wantedBy = [ "default.target" ];
    serviceConfig.ExecStart = "${pkgs.bluez}/bin/mpris-proxy";
  };
  
  services.xserver.windowManager.i3.extraPackages = with pkgs; [
    bluetuith	
 ];

}
