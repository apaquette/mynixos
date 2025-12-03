{
  config,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/gaming.nix
    ../../modules/software.nix
    ../../modules/kdePlasma.nix
  ];
}