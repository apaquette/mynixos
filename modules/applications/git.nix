{ userSettings, ... }:

{
  programs.git = {
    enable = true;
    lfs.enable = true;
    settings = {
      init.defaultBranch = "main";
      user = {
        name = userSettings.name;
        email = userSettings.email;
      };
    };
  };
}
