{ pkgs, ... }:

{
  # Allow unfree packages
  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [
      "electron-39.8.10"
    ];
  };

  services.flatpak.enable = true;
  
  # Git global configuration
  programs.git = {
    enable = true;
    lfs.enable = true;
    config.init.defaultBranch = "main";
  };

  # Enable Firefox
  programs.firefox = {
    enable = true;
    policies = {
      Certificates = {
        ImportEnterpriseRoots = true;
      };
    };
  };

  # Trust the Caddy local CA
  security.pki.certificateFiles = [
    ../certs/caddy-local-root.crt
  ];

  environment.systemPackages = with pkgs; [
    pciutils
    mdadm
    
    # KDE Packages
    kdePackages.kcalc # Calculator
    kdePackages.ktorrent
    kdePackages.kamoso #webcam app

    vlc
    obsidian
    zip
    onlyoffice-desktopeditors

    iw
  ];
}
