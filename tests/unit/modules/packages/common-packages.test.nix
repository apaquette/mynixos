{ pkgs, nixosConfigurations }:

let
  desktopConfig = nixosConfigurations.nixos-desktop.config;
in
asserts: [
  (builtins.elem "pciutils" desktopConfig.environment.systemPackages)
  (builtins.elem "mdadm" desktopConfig.environment.systemPackages)
]
