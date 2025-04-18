{
  pkgs,
  lib,
  config,
  ...
}: {
  services.openssh = {
    enable = true;

    settings = lib.mkMerge [
      (lib.mkIf (config.systemSettings.profile == "work") {
        PermitRootLogin = "without-password";
        Subsystem = "sftp internal-sftp";
      })
      (lib.mkIf (config.systemSettings.profile == "personal") {
        PermitRootLogin = "yes";
        Subsystem = "sftp internal-sftp";
      })
    ];
  };
}
