{ pkgs, username, ... }:

{
  virtualisation.docker = {
    enable = true;
    package = pkgs.docker_29;
  };

  users.users.${username}.extraGroups = [ "docker" ];
}
