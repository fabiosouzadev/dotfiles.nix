{lib, ...}: {
  swapDevices = lib.mkForce [
    {
      device = "/var/lib/swapfile";
      ## 16gb
      size = 16 * 1024;
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
    "vm.swappiness" = 180; # Troca processos para ZRAM mais agressivamente
    "vm.vfs_cache_pressure" = 50; # Mantém mais cache de arquivos em RAM
    "vm.dirty_ratio" = 10; # Escreve dados sujos mais cedo
    "vm.dirty_background_ratio" = 5;
  };

  # 3. Otimizar prioridade do Ollama
  systemd.services.ollama = {
    environment = {
      OLLAMA_NUM_PARALLEL = "4"; # Paralelismo para inferência
      OLLAMA_MAX_LOADED_MODELS = "2"; # Limitar modelos carregados
    };
    serviceConfig = {
      OOMScoreAdjust = -1000; # Prioridade máxima contra OOM Killer
      MemoryHigh = "12G"; # Limite soft de memória
      MemoryMax = "14G"; # Limite hard (reinicia o serviço se exceder)
      MemorySwapMax = "0"; # Não usar swap adicional
      Nice = -15; # Prioridade alta de CPU
      # CPUSchedulingPolicy = "rr"; # Round-Robin para uso justo de CPU
      IOSchedulingClass = "realtime"; # Máxima prioridade de I/O
    };
  };
}
