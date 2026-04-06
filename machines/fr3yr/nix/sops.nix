# sops-nix secrets configuration for fr3yr
{
  config,
  lib,
  ...
}:
{
  # Configure sops
  sops = {
    # The default sops file for this machine
    defaultSopsFile = ../../../secrets/fr3yr.yaml;

    # Use age for decryption
    age = {
      # Use the SSH host key for decryption
      sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
    };

    # Define the secrets - this creates the Home Assistant secrets.yaml
    secrets."home-assistant-secrets" = {
      owner = "hass";
      group = "hass";
      path = "/var/lib/hass/secrets.yaml";
      mode = "0600";
    };

    # WiFi credentials for wpa_supplicant
    secrets."wifi-secrets" = {
      mode = "0400";
    };
  };
}
