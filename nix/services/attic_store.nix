{
  config,
  lib,
  pkgs,
  ...
}: {

  # Attic watch-store: auto-push new store paths to nse_ep cache
  systemd.services.attic-watch-store = lib.mkIf (config.systemSettings.profile == "work") {
    description = "Attic watch-store — push new Nix store paths to nse_ep";
    after = ["network-online.target"];
    wants = ["network-online.target"];
    wantedBy = ["multi-user.target"];

    environment = {
      SSL_CERT_FILE = "/etc/ssl/certs/ca-certificates.crt";
      XDG_CONFIG_HOME = "/home/${config.userSettings.username}/.config";
    };

    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.attic-client}/bin/attic watch-store --ignore-upstream-cache-filter local:nse_ep";
      Restart = "on-failure";
      RestartSec = 10;
      RestartMaxDelaySec = "5min";
      RestartSteps = 5;
      StartLimitIntervalSec = 600;
      StartLimitBurst = 5;
      User = config.userSettings.username;
      Group = "users";
    };
  };

}

