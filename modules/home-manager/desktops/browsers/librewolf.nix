{...}: {
  programs.librewolf = {
    enable = true;
    settings = {
      "webgl.disabled" = false;
      "places.history.enabled" = false;
      "privacy.history.custom" = true;
      "privacy.clearHistory.siteSettings" = true;
      "privacy.clearHistory.cookiesAndStorage" = true;
      "privacy.clearHistory.historyFormDataAndDownloads" = true;
      "privacy.clearHistory.cache" = true;
      "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
      "extensions.webextensions.uuids" = "{\"formautofill@mozilla.org\":\"b836985f-498a-491b-be1a-03167dfbcfa7\",\"pictureinpicture@mozilla.org\":\"46ef013b-f533-4692-bc15-0c611a719fda\",\"screenshots@mozilla.org\":\"8a43adfa-76f0-4b3f-a6b7-a72bcca27cd6\",\"webcompat-reporter@mozilla.org\":\"47337b66-7b2d-414d-b2ea-2efe2ce15b69\",\"webcompat@mozilla.org\":\"76c02d0c-f010-4c82-9d73-4aca4948e63b\",\"default-theme@mozilla.org\":\"80a89a2d-e516-4b0f-bf8d-6874ec8be9bb\",\"addons-search-detection@mozilla.com\":\"71299a60-9682-4e9b-81e5-46279f7163b3\",\"uBlock0@raymondhill.net\":\"a983e00d-3df0-47c3-906c-feca774feba5\",\"imageblock@hemantvats.com\":\"636f64c3-3c8f-4c50-a1d4-2266fd9fd63e\",\"addon@darkreader.org\":\"8a8d3f74-f3e4-4c82-9d89-e5e567fb0742\"}";
    };
  };
}
