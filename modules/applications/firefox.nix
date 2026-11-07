{ pkgs, ... }:

{
  programs.firefox = {
    enable = true;
    policies = {
      Certificates = {
        ImportEnterpriseRoots = true;
      };
    };
  };
}
