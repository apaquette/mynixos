{ 
  config, 
  pkgs, 
  userSettings,
  ... 
}:

{
  imports = [
    ./vscode.nix
    #./plasma/default.nix
  ];
  

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    spotify
    discord
    #whatsie
    whatsapp-electron
    #nil
    kdePackages.kate
  ];

  

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = { };
  home.sessionVariables = { };

  nixpkgs.config.allowUnfree = true; # needed for vs code

  programs = {
    home-manager.enable = true;
    fish.enable = true;
    firefox.enable = true;
    git = {
      enable = true;
      userName = userSettings.username;
      userEmail = userSettings.email;
      extraConfig = {
        init.defaultBranch = "main";
      };
    };
  };

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.11"; # Please read the comment before changing.

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = userSettings.username;
  home.homeDirectory = "/home/${userSettings.username}";
}
