{ pkgs, ... }:

{
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable FISH command shell
  programs.fish.enable = true;
  
  # Git global configuration
  programs.git = {
    enable = true;
    config.init.defaultBranch = "main";
  };

  # Enable Firefox
  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
    pciutils
    mdadm
    
    # KDE Packages
    kdePackages.kcalc # Calculator
    kdePackages.ktorrent
    kdePackages.kamoso #webcam app

    vlc
    flameshot # for screenshots
    obsidian
    zip
    #LibreOffice
      # libreoffice-qt6-fresh
      # hunspell
      # hunspellDicts.en_CA
    # Only Office
    onlyoffice-desktopeditors
  ];
}
