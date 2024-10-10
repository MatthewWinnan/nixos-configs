# https://christitus.com/zoxide/
{
  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
    options = ["--cmd cd"];
  };
}
