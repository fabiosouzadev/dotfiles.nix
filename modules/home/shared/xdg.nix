{vars, ...}: let
  browser = ["${vars.browser}.desktop"];
  imgViewer = ["org.xfce.ristretto.desktop"];
  extractor = ["org.gnome.FileRoller.desktop"];
  defaultApplications = {
    #browser
    "application/x-extension-htm" = browser;
    "application/x-extension-html" = browser;
    "application/x-extension-shtml" = browser;
    "application/x-extension-xht" = browser;
    "application/x-extension-xhtml" = browser;
    "application/xhtml+xml" = browser;
    "application/json" = browser;
    "text/html" = browser;
    "text/xml" = browser;
    "x-scheme-handler/about" = browser;
    "x-scheme-handler/chrome" = ["chromium-browser.desktop"];
    "x-scheme-handler/ftp" = browser;
    "x-scheme-handler/http" = browser;
    "x-scheme-handler/https" = browser;
    "x-scheme-handler/unknown" = browser;
    "x-scheme-handler/msteams" = ["teams-for-linux.desktop"] ++ browser;

    "image/png" = imgViewer;
    "image/jpeg" = imgViewer;
    "image/jpg" = imgViewer;
    "image/webp" = imgViewer;
    "image/gif" = imgViewer;
    "image/svg" = imgViewer;
    "application/zip" = extractor;
    "text/plain" = ["mousepad.desktop"];
    "application/pdf" = ["zathura.desktop"] ++ browser;

    "audio/*" = ["mpv.desktop"];
    "video/*" = ["mpv.dekstop"];
    "image/*" = imgViewer;
    "x-scheme-handler/discord" = ["discord.desktop"];
    "x-scheme-handler/spotify" = ["spotify.desktop"];
    "x-scheme-handler/tg" = ["telegramdesktop.desktop"];
  };
in {
  xdg.mimeApps = {
    enable = true;

    defaultApplications = defaultApplications;
    associations.added = defaultApplications;
  };
}
