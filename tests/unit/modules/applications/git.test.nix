{ pkgs, nixosConfigurations }:

let
  desktopConfig = nixosConfigurations.nixos-desktop.config;
in
asserts: [
  (desktopConfig.programs.git.enable)
  (desktopConfig.programs.git.lfs.enable)
]
