{ 
  config, 
  pkgs, 
  userSettings,
  ...
}:

{
  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
    
  # Enable KDE Connect
  programs.kdeconnect.enable = true;

  users.users.${userSettings.username} = {
    packages = with pkgs; [
      kdePackages.kate
      kdePackages.kwalletmanager
    ];
  };

  security.pam.services.login.kwallet = {
    enable = true;
  };

  xdg.portal.enable = true;
}