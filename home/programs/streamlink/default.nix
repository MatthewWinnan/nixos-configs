# https://mynixos.com/home-manager/options/programs.streamlink
# https://github.com/streamlink/streamlink?tab=readme-ov-file
{
  pkgs,
  config,
  ...
}: {
  config.programs.streamlink = {
    enable = builtins.elem config.systemSettings.profile ["gaming" "personal"];
  };
}
