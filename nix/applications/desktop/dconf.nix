# registry for linux, thanks to gnome
{inputs, ...}: {
  programs.dconf = {
    enable = true;
  };
}
