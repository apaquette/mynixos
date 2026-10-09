{ pkgs, ... }:

{
  systemd.user.services.nextcloud-client = {
    Unit = {
      Description = "Nextcloud Desktop Client";
      After = [
        "graphical-session.target"
        "network-online.target"
      ];
      Wants = [
        "network-online.target"
      ];
    };

    Service = {
      ExecStart = "${pkgs.nextcloud-client}/bin/nextcloud";
      Restart = "on-failure";
      RestartSec = 10;
    };

    Install = {
      WantedBy = [
        "graphical-session.target"
      ];
    };
  };
}