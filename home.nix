{ config, pkgs, ... }:

{
  imports = [
    ./vscode.nix
  ];
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "apaquette";
  home.homeDirectory = "/home/apaquette";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    spotify
    discord
    whatsie
    nil
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
    # vscode = {
    #   enable = true;
    #   package = pkgs.vscode.fhs;

    #   profiles.default.enableUpdateCheck = false;
    #   profiles.default.enableExtensionUpdateCheck = false;

    #   profiles.default.extensions = with pkgs.vscode-extensions;
    #   [
    #     bbenoist.nix
    #     jnoortheen.nix-ide
    #     pkief.material-icon-theme
    #   ];

    #   profiles.default.userSettings = builtins.fromJSON '' {
    #       "diffEditor.ignoreTrimWhitespace": false,
    #       "editor.bracketPairColorization.enabled": true,
    #       "extensions.autoCheckUpdates": false,
    #       "git.autofetch": true,
    #       "update.mode": "none",
    #       "window.titleBarStyle": "custom",
    #       "workbench.iconTheme": "material-icon-theme",
    #       "git.confirmSync": false
    #     }'';
    # };
  };
}
