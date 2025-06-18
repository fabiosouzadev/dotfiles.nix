{
  config,
  pkgs,
  vars,
  ...
}: let
  model = "techlead-aggresive";
in {
  # 1. Habilitar serviço Ollama
  services.ollama = {
    enable = true;
    # loadModels = ["deepseek-coder:1.3b-instruct-q4_K_M" "deepseek-coder:6.7b-instruct-q4_K_M "];

    # Sobrescrever diretório padrão
    environmentVariables = {
      # Otimização para GPU Intel
      # OLLAMA_NUM_GPU_LAYERS = "10"; # Camadas GPU (testado como estável para Iris Xe)
      OLLAMA_LLM_LIBRARY = "vulkan"; # Backend para GPU Intel

      # Controle de memória
      OLLAMA_MAX_LOADED_MODELS = "1"; # Mantém apenas 1 modelo carregado
      OLLAMA_NUM_PARALLEL = "3"; # Processamento paralelo

      # Otimização de performance
      OLLAMA_NUM_CTX = "2048"; # Contexto reduzido para economia de RA
    };
  };
  ## Configuração do systemd.services
  systemd.services.ollama = {
    serviceConfig = {
      # Limites de memória
      MemoryMax = "13G";
      MemorySwapMax = "28G";
      OOMScoreAdjust = -500; # Proteção contra OOM Killer

      # Prioridade de CPU
      Nice = -10;
      CPUSchedulingPolicy = "rr";
      CPUSchedulingPriority = 5;

      # GPU Intel Iris Xe
      DeviceAllow = "/dev/dri rw";
      Environment = "VK_ICD_FILENAMES=/run/opengl-driver/share/vulkan/icd.d/intel_icd.x86_64.json";
    };
  };

  ### 3. Scripts
  # Link simbólico persistente
  # system.activationScripts = {
  # };

  services.udev.extraRules = ''
    # Prioriza processos usando GPU
    ACTION=="add", SUBSYSTEM=="drm", KERNEL=="renderD*", TAG+="systemd"
  '';

  ## Open-webui http://127.0.0.1:11435
  # services.open-webui = {
  #   enable = true;
  #   port = 11435;
  #   environment = {
  #     ANONYMIZED_TELEMETRY = "False";
  #     DO_NOT_TRACK = "True";
  #     SCARF_NO_ANALYTICS = "True";
  #     OLLAMA_API_BASE_URL = "http://127.0.0.1:11434/api";
  #     OLLAMA_BASE_URL = "http://127.0.0.1:11434";
  #     # # Disable authentication
  #     # WEBUI_AUTH = "False";
  #   };
  # };

  # Ai for cli https://github.com/block/goose
  # Ai for cli https://github.com/ggozad/oterm
  environment.systemPackages = with pkgs; [
    # ollama
    goose-cli
    # oterm
  ];

  programs.zsh = {
    interactiveShellInit = ''
      export OLLAMA_HOST=http://127.0.0.1:11434
    '';

    shellAliases = {
      ollc = "curl http://localhost:11434";
      ollp = "ollama pull";
      olls = "ollama ps";
      # ollw = "docker run -d -p 11435:8080 -v open-webui:/app/backend/data --name open-webui --add-host=host.docker.internal:host-gateway --restart always ghcr.io/open-webui/open-webui:main";
      ollr = "ollama run";
      olld = "ollama rm";
      # Seleciona um commit e resume suas mudanças
      ollama-commit-summary-fzf = "git log --oneline | fzf | cut -d ' ' -f 1 | xargs -I {} git show {} | ollama run ${model} \"Resuma as mudanças deste commit em bullet points focando no impacto para code review:\"";
      ollama-diff-summary = ''
        git diff | ollama run ${model} "Resuma estas mudanças em bullet points focando no impacto para code review:"
      '';
    };
  };
}
