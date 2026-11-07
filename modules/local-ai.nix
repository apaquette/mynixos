{ pkgs, pkgs-unstable, ... }:

{
  # Ensure the Mesa graphics stack is available for Vulkan inference.
  hardware.graphics.enable = true;

  # Local LLM inference server.
  services.ollama = {
    enable = true;

    # AMD GPU acceleration through Vulkan.
    package = pkgs-unstable.ollama-vulkan;

    # Restrict the API to the local machine.
    host = "127.0.0.1";
    port = 11434;

    # Limit resource consumption on the 6700 XT.
    environmentVariables = {
      OLLAMA_CONTEXT_LENGTH = "32768";
      OLLAMA_MAX_LOADED_MODELS = "1";
      OLLAMA_NUM_PARALLEL = "1";

      # Memory optimization
      OLLAMA_FLASH_ATTENTION = "1";
      OLLAMA_KV_CACHE_TYPE = "q8_0";


      # Automatically unload models after inactivity.
      OLLAMA_KEEP_ALIVE = "5m";
    };

    # Declare the models managed by this system.
    loadModels = [
      "qwen3.5:9b-q4_K_M"
      "qwen2.5-coder:7b"
    ];

    # Remove models not declared above.
    syncModels = true;
  };

  # General-purpose AI interface.
  services.open-webui = {
    enable = true;

    package = pkgs-unstable.open-webui;

    host = "127.0.0.1";
    port = 8080;

    environment = {
      # Local Ollama backend.
      OLLAMA_BASE_URL = "http://127.0.0.1:11434";

      # Enable web search using DuckDuckGo.
      ENABLE_WEB_SEARCH = "True";
      WEB_SEARCH_ENGINE = "duckduckgo";
      DDGS_BACKEND = "auto";
    };
  };

  # Start Open WebUI after Ollama.
  systemd.services.open-webui = {
    after = [ "ollama.service" ];
    wants = [ "ollama.service" ];
  };

  # User-level developer tools.
  users.users.apaquette.packages = with pkgs; [
    aider-chat
    vulkan-tools
  ];
}
