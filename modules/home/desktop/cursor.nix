{pkgs, ...}: {
  home.pointerCursor = {
    enable = true;
    x11.enable = true;
    gtk.enable = true;
    # name = "graphite-dark";
    # package = pkgs.graphite-cursors;
    # size = 24;
    name = "BreezeX-RosePine-Linux";
    package = pkgs.rose-pine-cursor;
    size = 24;
  };
}
