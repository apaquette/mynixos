{ 
  config, 
  pkgs, 
  userSettings,
  ... 
}: {
  imports = [
    ./vscode.nix
    #./plasma/default.nix
  ];
}