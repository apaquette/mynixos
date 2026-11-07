{ pkgs, pkgs-unstable, nixosConfigurations, homeConfigurations, userSettings, ... }:

let
  desktopConfig = nixosConfigurations.nixos-desktop.config;
  thinkpadConfig = nixosConfigurations.nixos-thinkpad.config;
  homeConfig = homeConfigurations.apaquette.config;

  # Safely checks a nested configuration value.
  # Returns false when any attribute in the path is missing.
  configValueEquals = config: path: expected:
    (pkgs.lib.attrByPath path null config) == expected;

  mkCheck = name: assertions:
    let
      indexedAssertions = builtins.genList
        (index: {
          inherit index;
          passed = builtins.elemAt assertions index;
        })
        (builtins.length assertions);

      failedAssertions = builtins.filter
        (assertion: !assertion.passed)
        indexedAssertions;

      failedIndices = builtins.concatStringsSep ", "
        (map (assertion: builtins.toString assertion.index)
          failedAssertions);
    in
    assert failedAssertions == []
      || throw "${name}: failed assertion indices: ${failedIndices}";
    pkgs.runCommand "mynixos-${name}" { } ''
      printf '%s\n' '${name}: passed' > "$out"
    '';

  # Unit tests for individual modules
  unitTests = mkCheck "unit-tests" [
    (desktopConfig.networking.hostName == "nixos-desktop")
    (homeConfig.home.username == "apaquette")
    (homeConfig.programs.fish.enable)
    (homeConfig.programs.git.enable)
  ];

  commonSystemAssertions = config: [
    (config.system.stateVersion == "25.11")
    (builtins.elem "nix-command" config.nix.settings.experimental-features)
    (builtins.elem "flakes" config.nix.settings.experimental-features)
    (config.networking.networkmanager.enable)
    (config.hardware.bluetooth.enable)
    (config.time.timeZone == "America/Halifax")
    (config.i18n.defaultLocale == "en_CA.UTF-8")
    (config.services.printing.enable)
    (config.services.pipewire.enable)
    (config.services.pipewire.alsa.enable)
    (config.services.pipewire.alsa.support32Bit)
    (config.services.pipewire.pulse.enable)
    (!config.services.pulseaudio.enable)
    (config.system.autoUpgrade.enable)
    (config.system.autoUpgrade.dates == "weekly")
    (config.programs.fish.enable)
    (config.users.users.apaquette.isNormalUser)
    (config.users.users.apaquette.description == "${userSettings.name} (${userSettings.email})")
    (builtins.elem "networkmanager" config.users.users.apaquette.extraGroups)
    (builtins.elem "wheel" config.users.users.apaquette.extraGroups)
  ];

in
{
  outputs = mkCheck "outputs" [
    (builtins.attrNames nixosConfigurations == [
      "nixos-desktop"
      "nixos-thinkpad"
    ])
    (builtins.attrNames homeConfigurations == [ "apaquette" ])
  ];

  unit-tests = unitTests;

  common-system = mkCheck "common-system" (
    commonSystemAssertions desktopConfig
    ++ commonSystemAssertions thinkpadConfig
    ++ [
      (thinkpadConfig.system.stateVersion == desktopConfig.system.stateVersion)
      (thinkpadConfig.services.desktopManager.plasma6.enable)
      (desktopConfig.services.desktopManager.plasma6.enable)
      (thinkpadConfig.services.displayManager.sddm.enable)
      (desktopConfig.services.displayManager.sddm.enable)
      (thinkpadConfig.programs.kdeconnect.enable)
      (desktopConfig.programs.kdeconnect.enable)
      (thinkpadConfig.xdg.portal.enable)
      (desktopConfig.xdg.portal.enable)
      (!(builtins.elem pkgs.nextcloud-client desktopConfig.environment.systemPackages))
    ]
  );

  home-manager = mkCheck "home-manager" [
    (homeConfig.home.username == "apaquette")
    (homeConfig.home.homeDirectory == "/home/apaquette")
    (homeConfig.home.stateVersion == "25.11")
    (homeConfig.programs.home-manager.enable)
    (homeConfig.programs.fish.enable)
    (homeConfig.programs.git.enable)
    (homeConfig.programs.vscode.enable)
    (homeConfig.services.flatpak.enable)
    (builtins.hasAttr "nextcloud-client" homeConfig.systemd.user.services)
    (homeConfig.programs.git.settings.user.name == "Alex Paquette")
    (homeConfig.programs.git.settings.user.email == "alexandre.d.paquette@gmail.com")
    (builtins.elem pkgs.kdePackages.kate homeConfig.home.packages)
    (builtins.elem pkgs.kdePackages.kwalletmanager homeConfig.home.packages)
    # VS Code configuration
    (homeConfig.programs.vscode.package == pkgs.vscode.fhs)
    (homeConfig.programs.vscode.profiles.default.enableUpdateCheck == false)
    (homeConfig.programs.vscode.profiles.default.enableExtensionUpdateCheck == false)
    (homeConfig.programs.vscode.profiles.default.userSettings."git.autofetch" == true)
    (homeConfig.programs.vscode.profiles.default.userSettings."window.titleBarStyle" == "custom")

    (builtins.elem pkgs.vscode-extensions.bbenoist.nix
      homeConfig.programs.vscode.profiles.default.extensions)
    (builtins.elem pkgs.vscode-extensions.jnoortheen.nix-ide
      homeConfig.programs.vscode.profiles.default.extensions)

    # Nextcloud client
    (builtins.elem pkgs.nextcloud-client homeConfig.home.packages)
    (homeConfig.systemd.user.services.nextcloud-client.Service.ExecStart
      == [ "${pkgs.nextcloud-client}/bin/nextcloud" ])
    (homeConfig.systemd.user.services.nextcloud-client.Service.Restart == "on-failure")
    (builtins.elem "graphical-session.target"
      homeConfig.systemd.user.services.nextcloud-client.Install.WantedBy)

    # Declarative Flatpak
    (homeConfig.services.flatpak.enable)
    (builtins.any
      (package:
        package.appId == "ai.storyteller.photocraft"
        && package.sha256 == "sha256-uLhEpJUfaHci/Mrn5E82C72v3xEpER2NEB6JNJTqMgI="
      )
      homeConfig.services.flatpak.packages)
    (builtins.any
      (package:
        package.appId == "ai.storyteller.filmcraft"
        && package.sha256 == "sha256-yabHY7v2v06maiBPVkU5LOo5/punTwiLDAgUnEltoaA="
      )
      homeConfig.services.flatpak.packages)

    # Plasma Manager is available but intentionally inactive
    (!homeConfig.programs.plasma.enable)
  ];

  local-ai = mkCheck "local-ai" [
    # Host isolation
    (desktopConfig.services.ollama.enable)
    (desktopConfig.services.open-webui.enable)
    (!thinkpadConfig.services.ollama.enable)
    (!thinkpadConfig.services.open-webui.enable)

    # GPU acceleration
    (desktopConfig.hardware.graphics.enable)
    (desktopConfig.services.ollama.package == pkgs-unstable.ollama-vulkan)

    # Ollama service
    (desktopConfig.services.ollama.host == "127.0.0.1")
    (desktopConfig.services.ollama.port == 11434)

    # Ollama resource limits
    (configValueEquals desktopConfig
      [ "systemd" "services" "ollama" "environment" "OLLAMA_CONTEXT_LENGTH" ]
      "32768")

    (configValueEquals desktopConfig
      [ "systemd" "services" "ollama" "environment" "OLLAMA_MAX_LOADED_MODELS" ]
      "1")

    (configValueEquals desktopConfig
      [ "systemd" "services" "ollama" "environment" "OLLAMA_NUM_PARALLEL" ]
      "1")
    (desktopConfig.services.ollama.syncModels)

    # KV cache optimization
    (configValueEquals desktopConfig
      [ "systemd" "services" "ollama" "environment" "OLLAMA_FLASH_ATTENTION" ]
      "1")

    (configValueEquals desktopConfig
      [ "systemd" "services" "ollama" "environment" "OLLAMA_KV_CACHE_TYPE" ]
      "q8_0")

    # Ollama network security
    (!desktopConfig.services.ollama.openFirewall)

    # Open WebUI service
    (desktopConfig.services.open-webui.host == "127.0.0.1")
    (desktopConfig.services.open-webui.port == 8080)
    (!desktopConfig.services.open-webui.openFirewall)

    # Ollama integration
    (configValueEquals desktopConfig
      [ "systemd" "services" "open-webui" "environment" "OLLAMA_BASE_URL" ]
      "http://127.0.0.1:11434")

    # Web search
    (configValueEquals desktopConfig
      [ "systemd" "services" "open-webui" "environment" "ENABLE_WEB_SEARCH" ]
      "True")

    (configValueEquals desktopConfig
      [ "systemd" "services" "open-webui" "environment" "WEB_SEARCH_ENGINE" ]
      "duckduckgo")

    (configValueEquals desktopConfig
      [ "systemd" "services" "open-webui" "environment" "DDGS_BACKEND" ]
      "auto")

    # Developer tools
    (builtins.elem pkgs.aider-chat
      desktopConfig.users.users.apaquette.packages)
    (builtins.elem pkgs.vulkan-tools
      desktopConfig.users.users.apaquette.packages)
  ];
}
