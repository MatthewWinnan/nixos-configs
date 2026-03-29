{
  pkgs,
  lib,
  config,
  ...
}: {
  services.fail2ban = {
    enable = true;

    maxretry = 5;
    bantime = "10m";
    bantime-increment = {
      enable = true;
      maxtime = "48h";
      factor = "4";
    };

    jails = {
      sshd = {
        settings = {
          enabled = true;
          port = "ssh";
          filter = "sshd";
          maxretry = 3;
          findtime = "10m";
          bantime = "1h";
        };
      };
    };
  };
}
