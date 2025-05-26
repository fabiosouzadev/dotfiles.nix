{pkgs, ...}: {
  # To edit use your text editor application, for example Nano
  services.ollama = {
    # package = pkgs.unstable.ollama; # If you want to use the unstable channel package for example
    enable = true;
    # acceleration = "rocm"; # Or "rocm"
    # Optional: preload models, see https://ollama.com/library
    # loadModels = ["llama3.2:3b" "deepseek-r1:1.8b"];
    # loadModels = ["llama3.2:3b" "deepseek-r1:8b" "qwen3:14b" "gemma3:12b"];
    loadModels = ["codellama:7b"];
  };

  ## http://127.0.0.1:11434/api
  services.open-webui = {
    enable = true;
    port = 11435;
    environment = {
      ANONYMIZED_TELEMETRY = "False";
      DO_NOT_TRACK = "True";
      SCARF_NO_ANALYTICS = "True";
      OLLAMA_API_BASE_URL = "http://127.0.0.1:11434/api";
      OLLAMA_BASE_URL = "http://127.0.0.1:11434";
      # # Disable authentication
      # WEBUI_AUTH = "False";
    };
  };

  programs.zsh = {
    interactiveShellInit = ''
      export OLLAMA_HOST=http://127.0.0.1:11434
    '';
  };

  # Ai for cli https://github.com/block/goose
  # Ai for cli https://github.com/ggozad/oterm
  environment.systemPackages = with pkgs; [
    goose-cli
    oterm
  ];
}
