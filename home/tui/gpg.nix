{ pkgs, ... }:
{
  programs.gpg.enable = true;
  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 31536000; # cache keys forever don't get asked for password
    defaultCacheTtlSsh = 31536000; # cache keys forever don't get asked for password
    maxCacheTtl = 31536000;
    maxCacheTtlSsh = 31536000;
    enableSshSupport = true;
    pinentryPackage = pkgs.pinentry-tty;
    # pinentryPackage = pkgs.pinentry-curses;
  };
}
