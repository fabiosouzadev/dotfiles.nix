{
  # Configure keymap in X11
  # services.xserver = {
  #   xkb = {
  #     layout = "us";
  #     variant = "alt-intl";
  #   };
  # };
  services.xserver = {
    layout = "us,br";
    # xkbVariant = "altgr-intl,abnt2";
    xkbVariant = "alt-intl,abnt2";
    xkbOptions = "grp:alt_caps_toggle";
  };
  # Configure console keymap
  console.keyMap = "dvorak";
}
