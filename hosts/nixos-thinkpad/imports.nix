{
  config,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/software.nix
    ../../modules/kde.nix
    ../../modules/settings.nix
    ../../modules/syncthing.nix
  ];
}
