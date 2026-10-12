{ pkgs, nixosConfigurations, homeConfigurations }:

let
  desktopConfig = nixosConfigurations.nixos-desktop.config;
  thinkpadConfig = nixosConfigurations.nixos-thinkpad.config;
  homeConfig = homeConfigurations.apaquette.config;

  mkCheck = name: assertions:
    assert builtins.all (assertion: assertion) assertions;
    pkgs.runCommand "mynixos-${name}" { } ''
      printf '%s\n' '${name}: passed' > "$out"
    '';

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
    (config.users.defaultUserShell.pname == "fish")
    (config.users.users.apaquette.isNormalUser)
    (config.users.users.apaquette.description == "Alex Paquette")
    (builtins.elem "networkmanager" config.users.users.apaquette.extraGroups)
    (builtins.elem "wheel" config.users.users.apaquette.extraGroups)
    (config.programs.git.enable)
    (config.programs.firefox.enable)
    (config.services.flatpak.enable)
    (config.users.users.apaquette.shell.pname == "fish")
    (config.users.users.apaquette.extraGroups == [
      "networkmanager"
      "wheel"
    ])
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
    ]
  );

  desktop = mkCheck "desktop" [
    (nixosConfigurations.nixos-desktop.config.networking.hostName == "nixos-desktop")
    (desktopConfig.boot.loader.systemd-boot.enable)
    (desktopConfig.boot.loader.efi.canTouchEfiVariables)
    (desktopConfig.services.xserver.enable)
    (desktopConfig.services.xserver.xkb.layout == "us")
    (desktopConfig.services.xserver.xkb.variant == "colemak")
    (desktopConfig.services.xserver.xkb.options == "caps:backspace")
    (!desktopConfig.networking.enableIPv6)
    (!desktopConfig.networking.networkmanager.wifi.powersave)
    (desktopConfig.services.displayManager.autoLogin.enable)
    (desktopConfig.services.displayManager.autoLogin.user == "apaquette")
    (desktopConfig.programs.steam.enable)
    (desktopConfig.hardware.xone.enable)
    (desktopConfig.services.displayManager.autoLogin.enable)
    (desktopConfig.services.displayManager.autoLogin.user == "apaquette")
  ];

  thinkpad = mkCheck "thinkpad" [
    (nixosConfigurations.nixos-thinkpad.config.networking.hostName == "nixos-thinkpad")
    (thinkpadConfig.boot.loader.systemd-boot.enable)
    (thinkpadConfig.boot.loader.efi.canTouchEfiVariables)
    (!thinkpadConfig.programs.steam.enable)
    (!thinkpadConfig.hardware.xone.enable)
    (!thinkpadConfig.services.displayManager.autoLogin.enable)
  ];

  home-manager = mkCheck "home-manager" [
    (homeConfig.home.username == "apaquette")
    (homeConfig.home.homeDirectory == "/home/apaquette")
    (homeConfig.home.stateVersion == "25.11")
    (homeConfig.programs.home-manager.enable)
    (homeConfig.programs.fish.enable)
    (homeConfig.programs.firefox.enable)
    (homeConfig.programs.git.enable)
    (homeConfig.programs.vscode.enable)
    (homeConfig.services.flatpak.enable)
    (builtins.hasAttr "nextcloud-client" homeConfig.systemd.user.services)
    (homeConfig.programs.git.settings.user.name == "Alex Paquette")
    (homeConfig.programs.git.settings.user.email == "alexandre.d.paquette@gmail.com")
  ];
}
