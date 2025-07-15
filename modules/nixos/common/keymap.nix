{
  # Configure keymap in X11
  services.xserver = {
    xkb = {
      layout = "us,br";
      variant = "alt-intl,abnt2";
      options = "grp:alt_caps_toggle,caps:swapescape";
    };
  };
  # Configure console keymap
  console.keyMap = "dvorak";
}
