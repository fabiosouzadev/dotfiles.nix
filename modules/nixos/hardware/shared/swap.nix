{lib, ...}: {
  swapDevices = lib.mkForce [
    {
      device = "/var/lib/swapfile";
      size = 32 * 1024; #20 GB
    }
  ];

  # 1. Habilitar módulo ZRAM com configuração agressiva
  zramSwap = {
    enable = true;
    memoryPercent = 200; # Até 200% da RAM física (32GB virtual)
    algorithm = "zstd"; # Melhor taxa de compressão (ou "lz4" para menos CPU)
    priority = 10; # Máxima prioridade sobre swap em disco
  };
  # 2. Kernel Tuning para carga intensa de LLMs
  boot.kernel.sysctl = {
    "vm.swappiness" = 180; # Troca processos para ZRAM mais agressivamente
    "vm.vfs_cache_pressure" = 50; # Mantém mais cache de arquivos em RAM
    "vm.dirty_ratio" = 10; # Escreve dados sujos mais cedo
    "vm.dirty_background_ratio" = 5;
  };

  # 3. Otimizar prioridade do Ollama
  systemd.services.ollama.serviceConfig = {
    IOSchedulingClass = "realtime"; # Máxima prioridade de I/O
    CPUSchedulingPolicy = "rr"; # Round-Robin para uso justo de CPU
    Nice = -10; # Prioridade alta no escalonamento
    OOMScoreAdjust = -500; # Protege contra OOM Killer
  };
  # 4. Configuração extra para sistemas com GPU integrada
  # hardware.opengl.enable = true;
  # services.udev.extraRules = ''
  #   # Prioriza processos usando GPU
  #   ACTION=="add", SUBSYSTEM=="drm", KERNEL=="renderD*", TAG+="systemd"
  # '';
}
