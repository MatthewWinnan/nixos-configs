# https://github.com/localsend/localsend
{ config, ... }:
{
  programs.localsend = {
    enable = config.systemSettings.profile == "personal" || config.systemSettings.profile == "gaming";
    openFirewall = true;
  };
}
