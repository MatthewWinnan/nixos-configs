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
      (lib.mkIf (config.systemSettings.profile != "work") {
        # Root by key only, never by password. Not "no": deploys run as
        # `nixos-rebuild --target-host root@<host>`, and root key auth is
        # already working on th0r, so "no" would break the deploy path the
        # moment it activated. This still closes what "yes" left open, which
        # was accepting a root *password* on the internet-facing hosts.
        PermitRootLogin = "prohibit-password";
        Subsystem = "sftp internal-sftp";

        # Key auth only. Keys are declared in nix/user/default.nix, so any host
        # built from this flake has them. Verify with a real login before
        # rebuilding a host you cannot reach physically - see the mkForce
        # override in machines/fr3yr/nix/ssh.nix for the escape hatch.
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
