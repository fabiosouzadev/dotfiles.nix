{lib, ...}: {
  swapDevices = lib.mkForce [
    {
      devices = "/var/lib/swapfile";
      tamanho = 20 * 1024; #20 GB
    }
  ];

  zramSwap = {
    enable = true; # Creates a zram block device and uses it as a swap device
    # Adicionar partição
    #writebackDevice = "/dev/sda1"
  };
}
