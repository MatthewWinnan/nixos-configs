{
  pkgs,
  lib,
  config,
  ...
}: {
  services.fail2ban = {
    enable = true;

    # No ignoreIP: fail2ban polices every source, including LAN and tailnet.
    # Deliberate - the sshd jail is the brute-force defence for password auth,
    # which stays enabled. Note this means your own machines can be banned;
    # `fail2ban-client unban --all` from the console is the way out.
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
