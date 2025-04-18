{pkgs, ...}:
{
  virtualisation = {
    docker = {
      enable = false;
      enableOnBoot = true;
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
    };
  };
}
