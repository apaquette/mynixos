{ ... }:

{
  imports = [
    ./configuration.nix

    ../../modules/software.nix

    ../../modules/base/networking.nix
    ../../modules/base/system.nix
    ../../modules/base/i18n.nix
    ../../modules/base/audio.nix

    ../../modules/desktop/display-manager.nix
    ../../modules/desktop/xserver.nix
    ../../modules/desktop/portal.nix
    ../../modules/kde.nix
  ];
}