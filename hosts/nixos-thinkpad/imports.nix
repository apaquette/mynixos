{
  config,
  ...
}:
{
  imports = [
    ../common/imports.nix
    ./hardware-configuration.nix
    ../../modules/software.nix
    ../../modules/kde.nix
    ../../modules/settings.nix
  ];
}
