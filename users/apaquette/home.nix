{ config, pkgs, userSettings, ... }:

{
  home.packages = with pkgs; [
    spotify
    discord
    whatsapp-electron
    kdePackages.kate
    kdePackages.kwalletmanager
    nextcloud-client
    jellyfin-rpc
    anki
    obs-studio
    unrar
    drawio
    inkscape
    github-desktop
  ];

  home.sessionVariables = { 
    OLLAMA_API_BASE = "http://127.0.0.1:11434";
  };

  programs = {
    home-manager.enable = true;
    fish.enable = true;
    firefox.enable = true;
    
    git = {
      enable = true;
      settings = {
        user.name = userSettings.name;
        user.email = userSettings.email;
        init.defaultBranch = "main";
      };
    };
  };

  home.stateVersion = "25.11";
  home.username = userSettings.username;
  home.homeDirectory = "/home/${userSettings.username}";
}
