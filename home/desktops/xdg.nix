{
  xdg.mimeApps.enable = true;
  xdg.mimeApps.defaultApplications = {
    "image/png" = ["pix.desktop"];
    "image/jpeg" = ["pix.desktop"];
    "image/webp" = ["pix.desktop"];
    "image/gif" = ["pix.desktop"];
    # "application/json" = ["emacsclient.desktop"];
    "text/plain" = ["mousepad.desktop"];
    "application/pdf" = ["zathura.desktop" "brave.desktop"];
    "text/html" = ["brave.desktop"];
    "text/xml" = ["brave.desktop"];
    "x-scheme-handler/http" = ["brave.desktop"];
    "x-scheme-handler/https" = ["brave.desktop"];
    "x-scheme-handler/msteams" = ["firefox.desktop"];
    "x-scheme-handler/about" = ["brave.desktop"];
    "x-scheme-handler/unknown" = ["brave.desktop"];
  };
}
