{
  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
    controlPersist = "1h";
  };
}
