{ pkgs, nixosConfigurations }:

let
  desktopConfig = nixosConfigurations.nixos-desktop.config;
in
asserts: [
  (desktopConfig.system.stateVersion == "25.11")
  (builtins.elem "nix-command" desktopConfig.nix.settings.experimental-features)
  (builtins.elem "flakes" desktopConfig.nix.settings.experimental-features)
  (desktopConfig.system.autoUpgrade.enable)
  (desktopConfig.system.autoUpgrade.dates == "weekly")
]
