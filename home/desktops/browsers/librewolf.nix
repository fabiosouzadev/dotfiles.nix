{...}: {
  programs.librewolf = {
    enable = true;
    settings = {
      "browser.safebrowsing.downloads.enabled" = true;
      "browser.search.suggest.enabled" = true;
      "browser.urlbar.suggest.searches" = true;
      "browser.toolbars.bookmarks.visibility" = "always";
      "identity.fxaccounts.enabled" = true;
      "privacy.clearOnShutdown.history" = false;
      "privacy.clearOnShutdown.cookies" = false;
    };
  };
}
