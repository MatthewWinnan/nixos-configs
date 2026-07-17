# sops-nix secrets configuration for fafn1r
{config, ...}: {
  sops = {
    defaultSopsFile = ../../../secrets/fafn1r.yaml;

    age = {
      sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
    };

    secrets = {
      "git-email" = {};
      "dns-search-domain" = {};
      "ssh-host-nse-services" = {};
      "ssh-host-nse-5" = {};
      "ssh-host-nse-6" = {};
      "ssh-host-nse-7" = {};
      "ssh-host-nse-8" = {};
      "ssh-host-nse-9" = {};
      "ssh-host-nse-10" = {};
      "ssh-host-grys" = {};
      "ssh-host-groenslang" = {};
      "ssh-host-gerrit" = {};
    };

    templates."git-work-config" = {
      content = ''
        [user]
          email = ${config.sops.placeholder."git-email"}
      '';
      owner = config.users.users.matthew.name;
    };

    templates."ssh-work-config" = {
      content = ''
        Host gerrit
          Hostname ${config.sops.placeholder."ssh-host-gerrit"}
          User mwinnan
          Port 29418
          PreferredAuthentications publickey

        Host nse-services
          Hostname ${config.sops.placeholder."ssh-host-nse-services"}
          User nse

        Host nse-5
          Hostname ${config.sops.placeholder."ssh-host-nse-5"}
          User root

        Host nse-6
          Hostname ${config.sops.placeholder."ssh-host-nse-6"}
          User root

        Host nse-7
          Hostname ${config.sops.placeholder."ssh-host-nse-7"}
          User root

        Host nse-8
          Hostname ${config.sops.placeholder."ssh-host-nse-8"}
          User root

        Host nse-9
          Hostname ${config.sops.placeholder."ssh-host-nse-9"}
          User root

        Host nse-10
          Hostname ${config.sops.placeholder."ssh-host-nse-10"}
          User root

        Host grys
          Hostname ${config.sops.placeholder."ssh-host-grys"}
          User mwinnan

        Host groenslang
          Hostname ${config.sops.placeholder."ssh-host-groenslang"}
          User gitlab-runner
      '';
      owner = config.users.users.matthew.name;
      path = "/etc/ssh/ssh_config.d/work-hosts.conf";
    };
  };

  # openresolv sources resolvconf.conf as a shell script, so we can
  # source our sops-decrypted secret to set the search domain at runtime
  networking.resolvconf.extraConfig = ''
    search_domains_append="$(cat ${config.sops.secrets."dns-search-domain".path} 2>/dev/null)"
  '';
}
