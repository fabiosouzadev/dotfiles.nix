{...}: {
  programs.librewolf = {
    enable = true;
    settings = {
      "browser.safebrowsing.downloads.enabled" = true;
      "browser.search.suggest.enabled" = true;
      "browser.urlbar.suggest.searches" = true;
      "browser.toolbars.bookmarks.visibility" = "always";
      "identity.fxaccounts.enabled" = false;
      "privacy.clearOnShutdown.history" = true;
      "privacy.clearOnShutdown.cookies" = true;
      "privacy.clearOnShutdown.sessions" = true;
    };
  };
}
