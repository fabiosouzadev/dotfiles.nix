{
  pkgs,
  config,
  ...
}: {
  boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.extraModulePackages = with config.boot.kernelPackages; [
    rtl8821ce
  ];
  environment.systemPackages = [
    pkgs.linuxKernel.packages.linux_zen.rtl8821ce
  ];
}
