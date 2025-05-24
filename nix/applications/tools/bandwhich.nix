# show network usage
{inputs, ...}: {
  programs.bandwhich = {
    enable = true;
  };
}
