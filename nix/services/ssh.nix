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
        # Root via Vault-signed certificate only, never a password.
        PermitRootLogin = "without-password";
        Subsystem = "sftp internal-sftp";
        TrustedUserCAKeys = "/etc/ssh/trusted-user-ca-keys.pem";

        # Key/certificate auth only. Certificates authenticate as pubkey, so the
        # Vault CA path above is unaffected. Note this removes password as a
        # fallback if a signed cert ever expires - console login still works.
        PasswordAuthentication = false;
      })
      (lib.mkIf (config.systemSettings.profile != "work" && !config.deviceSettings.homelab) {
        # Non-work, non-homelab machines: password auth allowed.
        PermitRootLogin = "prohibit-password";
        Subsystem = "sftp internal-sftp";
      })
      (lib.mkIf (config.systemSettings.profile != "work" && config.deviceSettings.homelab) {
        # Homelab machines: key auth only. These are internet-facing and
        # must not accept passwords.
        PermitRootLogin = "prohibit-password";
        Subsystem = "sftp internal-sftp";
        PasswordAuthentication = false;
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
