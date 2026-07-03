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
        TrustedUserCAKeys = "/etc/ssh/trusted-user-ca-keys.pem";
      })
      (lib.mkIf (config.systemSettings.profile == "personal") {
        PermitRootLogin = "yes";
        Subsystem = "sftp internal-sftp";
      })
    ];
  };

  # Vault SSH CA public key — allows cert-based authentication
  # for users who have their key signed by the Vault CA.
  # Regenerate with: vault read -field=public_key ssh-client-signer/config/ca
  environment.etc."ssh/trusted-user-ca-keys.pem" = lib.mkIf (config.systemSettings.profile == "work") {
    text = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIL6FC4/ko3Vbf9ImrixxoZjKCGH/maVZjw9MDchFgBVg";
    mode = "0644";
  };
}
