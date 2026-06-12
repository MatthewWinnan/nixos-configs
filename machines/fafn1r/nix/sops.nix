# sops-nix secrets configuration for fafn1r
{config, ...}: {
  sops = {
    defaultSopsFile = ../../../secrets/fafn1r.yaml;

    age = {
      sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
    };

    secrets."git-email" = {};
    secrets."dns-search-domain" = {};

    templates."git-work-config" = {
      content = ''
        [user]
          email = ${config.sops.placeholder."git-email"}
      '';
      owner = config.users.users.matthew.name;
    };
  };

  # openresolv sources resolvconf.conf as a shell script, so we can
  # source our sops-decrypted secret to set the search domain at runtime
  networking.resolvconf.extraConfig = ''
    search_domains_append="$(cat ${config.sops.secrets."dns-search-domain".path} 2>/dev/null)"
  '';
}
