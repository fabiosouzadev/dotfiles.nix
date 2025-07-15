{
  # Configure keymap in X11
  services.xserver = {
    xkb = {
      layout = "us,br";
      variant = "alt-intl,abnt2";
      options = "grp:alt_caps_toggle,caps:escape";
    };
  };
  # Configure console keymap
  console.keyMap = "dvorak";
}
