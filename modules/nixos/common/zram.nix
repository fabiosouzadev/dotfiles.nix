{lib, ...}: {
  swapDevices = lib.mkForce [
    {
      device = "/.swapfile"; # Caminho recomendado
      size = 16 * 1024; # 16GB (igual à RAM física)
      # priority = 0; # Último recurso
    }
  ];

  # 1. Habilitar módulo ZRAM com configuração agressiva
  zramSwap = {
    enable = true;
    memoryPercent = 200; # Até 200% da RAM física (32GB virtual)
    algorithm = "zstd"; # Melhor taxa de compressão (ou "lz4" para menos CPU)
    # algorithm = "lz4"; # Melhor taxa de compressão (ou "lz4" para menos CPU)
    priority = 10; # Máxima prioridade sobre swap em disco
  };
  # 2. Kernel Tuning para carga intensa de LLMs
  boot.kernel.sysctl = {
    "vm.swappiness" = 200; # Troca processos para ZRAM mais agressivamente
    # "vm.swappiness" = 10; # Baixa prioridade para swap em disco
    "vm.vfs_cache_pressure" = 50; # Mantém mais cache de arquivos em RAM
    "vm.dirty_ratio" = 10; # Escreve dados sujos mais cedo
    "vm.dirty_background_ratio" = 5;

    #for llm
    "vm.dirty_writeback_centisecs" = 6000;
    "vm.dirty_expire_centisecs" = 20000;
    "vm.stat_interval" = 10;
    "kernel.sched_migration_cost_ns" = 500000;
  };
}
