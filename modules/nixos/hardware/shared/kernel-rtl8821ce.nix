{
  pkgs,
  config,
  ...
}: {
  # Habilitar driver proprietário para Realtek RTL8821CE
  hardware.enableRedistributableFirmware = true;
  hardware.enableAllFirmware = true;
  # hardware.rtl8821ce.enable = true;
  # Firmware adicional
  hardware.firmware = with pkgs; [
    linux-firmware
    # rtl88xx2-aircrack-firmware
  ];

  boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.extraModulePackages = with config.boot.kernelPackages; [
    rtl8821ce
  ];
  # Carrega o módulo necessário no boot
  boot.kernelModules = ["8821ce"];
  boot.extraModprobeConfig = ''
    options rtl8821ce power_save=0 ips=0
  '';

  environment.systemPackages = with pkgs; [
    linuxKernel.packages.linux_zen.rtl8821ce
    iw
    wget
    wireless-regdb
  ];

  # Configurações de energia relacionadas à rede
  powerManagement = {
    enable = true;
    powertop.enable = true;
  };
}
