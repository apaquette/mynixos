{ config, pkgs, lib, ... }:

{
  system.stateVersion = "25.11";
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.autoUpgrade.enable = true;
  system.autoUpgrade.dates = "weekly";
}
