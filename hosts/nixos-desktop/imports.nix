# https://wiki.nixos.org/wiki/Jellyfin
{
  config,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/gaming.nix
    ../../modules/software.nix
    ../../modules/kde.nix
    ../../modules/settings.nix
    ../../modules/syncthing.nix
  ];
}