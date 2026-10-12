{
  config,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ../../users/apaquette/nixos.nix
    ../../modules/software.nix
    ../../modules/kde.nix
    ../../modules/settings.nix
  ];
}
