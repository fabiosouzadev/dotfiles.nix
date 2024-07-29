{pkgs, ...}: {
  # networking.nameservers = ["2620:fe::fe" "2620:fe::9"]; #quad9.net
  networking.resolvconf.enable = pkgs.lib.mkForce false;
  networking.dhcpcd.extraConfig = "nohook resolv.conf";
  networking.networkmanager.dns = "none";
  networking.nameservers = ["127.0.0.1" "::1"];
  services.dnscrypt-proxy2 = {
    enable = true;
    settings = {
      ipv6_servers = true;
      require_dnssec = true;

      sources.public-resolvers = {
        urls = [
          "https://quad9.net/dnscrypt/quad9-resolvers.md"
          "https://raw.githubusercontent.com/Quad9DNS/dnscrypt-settings/main/dnscrypt/quad9-resolvers.md"
        ];
        cache_file = "/var/lib/dnscrypt-proxy2/quad9-resolvers.md";
        minisign_key = "RWQBphd2+f6eiAqBsvDZEBXBGHQBJfeG6G+wJPPKxCZMoEQYpmoysKUN";
        refresh_delay = 72;
        prefix = "quad9-";
      };

      server_names = ["quad9-dns-doh"];
    };
  };
  services.resolved.enable = false;
  systemd.services.dnscrypt-proxy2.serviceConfig = {
    StateDirectory = "dnscrypt-proxy";
  };
}
