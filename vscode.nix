{ pkgs, ... }:

{
    programs.vscode = {
      enable = true;
      package = pkgs.vscode.fhs;

      profiles.default.enableUpdateCheck = false;
      profiles.default.enableExtensionUpdateCheck = false;

      profiles.default.extensions = with pkgs.vscode-extensions;
      [
        bbenoist.nix
        jnoortheen.nix-ide
        pkief.material-icon-theme
      ];

      profiles.default.userSettings = builtins.fromJSON '' {
          "diffEditor.ignoreTrimWhitespace": false,
          "editor.bracketPairColorization.enabled": true,
          "extensions.autoCheckUpdates": false,
          "git.autofetch": true,
          "update.mode": "none",
          "window.titleBarStyle": "custom",
          "workbench.iconTheme": "material-icon-theme",
          "git.confirmSync": false
        }'';
    };
}