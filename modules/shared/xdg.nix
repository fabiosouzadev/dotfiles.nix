let
  browser = ["brave.desktop"];
  imgViewer = ["org.xfce.ristretto.desktop"];
  extractor = ["org.gnome.FileRoller.desktop"];
  defaultApplications = {
    "image/png" = imgViewer;
    "image/jpeg" = imgViewer;
    "image/jpg" = imgViewer;
    "image/webp" = imgViewer;
    "image/gif" = imgViewer;
    "image/svg" = imgViewer;
    # "application/json" = ["emacsclient.desktop"];
    "application/zip" = extractor;
    "text/plain" = ["mousepad.desktop"];
    "application/pdf" = ["zathura.desktop"] ++ browser;
    "text/html" = browser;
    "text/xml" = browser;
    "x-scheme-handler/http" = browser;
    "x-scheme-handler/https" = browser;
    "x-scheme-handler/about" = browser;
    "x-scheme-handler/unknown" = browser;
    "x-scheme-handler/msteams" = ["teams-for-linux.desktop"] ++ browser;
  };
in {
  xdg.mimeApps = {
    enable = true;

    defaultApplications = defaultApplications;
    association.added = defaultApplications;
  };
}
