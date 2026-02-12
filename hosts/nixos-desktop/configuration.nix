{
  config,
  pkgs,
  lib,
  userSettings,
  ...
}:
{
  config = {
    # Bootloader.
    # boot.loader.efi.canTouchEfiVariables = true;
    # boot.loader.efi.efiSysMountPoint = "/boot";
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    # Dual-boot config
    # boot.loader.grub = {
    #   enable = true;
    #   device = "nodev";
    #   useOSProber = true;
    # };

    services.xserver = {
      enable = true;

      xkb = {
        layout = "us";
        variant = "colemak";
        options = "caps:backspace";
      };
    };

    # Enable automatic login for the user.
    services.displayManager.autoLogin.enable = true;
    services.displayManager.autoLogin.user = userSettings.username;
    
    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "25.11"; # Did you read the comment?

    nix.settings.experimental-features = [ "nix-command" "flakes" ];
  };
}
