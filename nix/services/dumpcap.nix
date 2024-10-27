{ pkgs, config, lib, ... }:

{
  # Conditionally define the `set-dumpcap-capabilities` service only if the profile is "work"
  systemd.services.set-dumpcap-capabilities = lib.mkIf (config.systemSettings.profile == "work") {
      description = "Set capabilities for dumpcap to allow non-root users to capture packets";
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${pkgs.coreutils}/bin/setcap cap_net_raw,cap_net_admin=eip ${pkgs.wireshark}/bin/dumpcap";
        RemainAfterExit = true;
      };
  };
}

