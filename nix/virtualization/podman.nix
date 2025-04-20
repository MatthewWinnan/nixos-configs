# This is to addresst the annoying differences between docker and systemd so I can run arion
# https://github.com/hercules-ci/arion/issues/122
{pkgs, ...}: {
  virtualisation = {
    podman = {
      enable = true;
      dockerSocket.enable = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };
}
