
{ ... }:

{
  # KDE Plasma desktop infrastructure.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Desktop integration.
  programs.kdeconnect.enable = true;
  security.pam.services.login.kwallet.enable = true;
  xdg.portal.enable = true;
}
