{ pkgs, nixosConfigurations }:

let
  desktopConfig = nixosConfigurations.nixos-desktop.config;
in
asserts: [
  (desktopConfig.hardware.bluetooth.enable)
  (desktopConfig.security.rtkit.enable)
  (desktopConfig.services.pipewire.enable)
  (desktopConfig.services.pipewire.alsa.enable)
  (desktopConfig.services.pipewire.pulse.enable)
  (!desktopConfig.services.pulseaudio.enable)
]
