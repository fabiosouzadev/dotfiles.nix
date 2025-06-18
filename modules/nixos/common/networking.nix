{
  pkgs,
  config,
  ...
}: {
  # Configuração de rede
  networking = {
    networkmanager.enable = true; # Recomendado para laptops
    useDHCP = false;
    interfaces."wlp2s0".useDHCP = true; # Verifique o nome da interface com 'ip a'
    networkmanager.dns = "systemd-resolved";
  };
  # networking.networkmanager.ensureProfiles.profiles = {
  #   "minha-rede-wifi" = {
  #     connection = {
  #       id = "minha-rede-wifi";
  #       type = "wifi";
  #       interface-name = "wlp2s0"; # nome real aqui
  #     };
  #     wifi = {
  #       ssid = "NI-FAMILIA@SALINAS-5G";
  #       mode = "infrastructure";
  #       security = "wpa-psk";
  #     };
  #     wifi-security = {
  #       key-mgmt = "wpa-psk";
  #       psk = "xxx";
  #     };
  #     ipv4 = {
  #       method = "auto";
  #     };
  #     ipv6 = {
  #       method = "auto";
  #     };
  #   };
  # };
}
