# For auto mountinf disks
# Docs https://github.com/coldfix/udiskie
# https://github.com/coldfix/udiskie/blob/master/doc/udiskie.8.txt#configuration
{
  services = {
    udiskie = {
      enable = true;
      automount = true;
      tray = "auto";
    };
  };
}
