{
  pkgs,
  lib,
  vars,
  ...
}: {
  # To edit use your text editor application, for example Nano
  services.ollama = {
    # package = pkgs.unstable.ollama; # If you want to use the unstable channel package for example
    enable = true;
    # acceleration = "rocm"; # Or "rocm"
    # Optional: preload models, see https://ollama.com/library
    loadModels = ["deepseek-coder:1.3b-instruct-q4_K_M" "codellama:7b-instruct-q2_K"];
  };

  ## http://127.0.0.1:11435
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
      WEBUI_AUTH = "False";
    };
  };

  # environment.systemPackages = [
  #   (pkgs.ollama.override {
  #     acceleration = "cuda";
  #   })
  # ];

  programs.zsh = {
    interactiveShellInit = ''
      export OLLAMA_HOST=http://127.0.0.1:11434
    '';
    shellAliases = {
      oll = "curl http://localhost:11434";
      opu = "ollama pull";
      ops = "ollama ps";
      ollamaweb = "docker run -d -p 3000:3000 -e OLLAMA_BASE_URL=http://host:11434 ghcr.io/open-webui/open-webui:main";
    };
  };
}
