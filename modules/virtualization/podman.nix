
{  config, pkgs, defaultUser, defaultGit, ... }:

{
    virtualisation = {
        podman = {
          enable = true;
          # dockerCompat = true;
          # extraPackages = with pkgs; [zfs];
          defaultNetwork.settings.dns_enabled = true;
          # Periodically prune Podman resources
          autoPrune = {
            enable = true;
            dates = "weekly";
            flags = ["--all"];
          };
        };

        oci-containers = {
            backend = "podman";
            # container-name = {
            #   image = "container-image";
            #   autoStart = true;
            #   ports = [ "127.0.0.1:1234:1234" ];
            # };
        };
    };
    environment.systemPackages = with pkgs; [
        #distrobox
        podman-compose
        podman-tui
        podman-desktop
        pods
    ];
}
