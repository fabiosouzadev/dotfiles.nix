{pkgs, ...}: {
  programs.gpg.enable = true;
  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 34560000; # cache keys forever don't get asked for password
    defaultCacheTtlSsh = 34560000; # cache keys forever don't get asked for password
    maxCacheTtl = 34560000;
    maxCacheTtlSsh = 34560000;
    enableSshSupport = true;
    pinentryPackage = pkgs.pinentry-tty;
    # pinentryPackage = pkgs.pinentry-curses;
  };
}
