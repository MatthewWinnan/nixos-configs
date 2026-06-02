# sops-nix secrets configuration for fafn1r
{config, ...}: {
  sops = {
    defaultSopsFile = ../../../secrets/fafn1r.yaml;

    age = {
      sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
    };

    secrets."git-email" = {};

    templates."git-work-config" = {
      content = ''
        [user]
          email = ${config.sops.placeholder."git-email"}
      '';
      owner = config.users.users.matthew.name;
    };
  };
}
