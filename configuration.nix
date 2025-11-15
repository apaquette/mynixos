# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  config,
  pkgs,
  lib,
  inputs,
  vars,
  ...
}: let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/master.tar.gz";
  inherit (lib) mkIf types mkOption;
in {
  imports = [
    ./hardware-configuration.nix # Include the results of the hardware scan.
    ./gaming.nix
    ./software.nix
    (import "${home-manager}/nixos")
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Enable Bluetooth
  hardware.bluetooth.enable = true;

  # Bootloader.
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.useOSProber = true;

  # Old bootloader
  # boot.loader.systemd-boot.enable = true;
  # boot.loader.efi.canTouchEfiVariables = true;
  

  networking.hostName = "nixos"; # Define your hostname.
  #networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Halifax";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_CA.UTF-8";

  # Desktop customization START

  # Enable the X11 windowing system.# You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  #services.displayManager.sddm.enable = true;

  services.displayManager.sddm = {
    enable = true;
  };

  services.desktopManager.plasma6 = {
    enable = true;
  };


  # Desktop customization END

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    # media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.apaquette = {
    isNormalUser = true;
    shell = pkgs.fish;
    description = "Alex Paquette";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      kdePackages.kate
    ];
  };

  home-manager.users.apaquette = {
    home.stateVersion = "18.09";
      programs.vscode = {
        enable = true;
        package = pkgs.vscode.fhs;
        profiles.default.enableUpdateCheck = false;
        profiles.default.enableExtensionUpdateCheck = false;
        profiles.default.extensions = with pkgs.vscode-extensions;
          [
            ms-dotnettools.csdevkit
            ms-dotnettools.csharp
            ms-dotnettools.vscode-dotnet-runtime
            ms-dotnettools.vscodeintellicode-csharp
          ];

        profiles.default.userSettings = builtins.fromJSON '' {
            "diffEditor.ignoreTrimWhitespace": false,
            "editor.bracketPairColorization.enabled": true,
            "window.titleBarStyle": "custom"
          }'';
      };

      home.packages = with pkgs; [
        alejandra # Nix Code Formatter                        https://github.com/kamadorueda/alejandra
        nil # Nix Language Server                             https://github.com/oxalica/nil
      ];
    };

  /*config = {

  };*/

  users.defaultUserShell = pkgs.fish;

  # Enable automatic login for the user.
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "apaquette";

  # Automatic updating
  system.autoUpgrade = {
    enable = true;
    dates = "weekly";
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable FISH command shell
  programs.fish.enable = true;

  # Enable Firefox
  programs.firefox.enable = true;

  # Enable KDE Connect
  programs.kdeconnect.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    dotnetCorePackages.sdk_9_0-bin
    iw
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
  ];


  programs.git = {
    enable = true;
    config = {
      init.defaultBranch = "main";
      user.name = "Alex Paquette";
      user.email = "alexandre.d.paquette@gmail.com";
    };
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
