{ pkgs, ... }:
{
  # Enable xone for Xbox wireless adapter
  hardware.xone.enable = true;
  
  # Enable Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
    extraCompatPackages = with pkgs; [ proton-ge-bin ];
  };

  environment.systemPackages = with pkgs; [
    heroic # Epic Games, GOG
    prismlauncher # Minecraft

    # Emulators
    dolphin-emu # Gamecube/Wii
    xenia-canary # Xbox 360
    rpcs3 # PS3
  ];
}
