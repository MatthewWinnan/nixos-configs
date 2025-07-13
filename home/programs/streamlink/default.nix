# https://mynixos.com/home-manager/options/programs.streamlink
# https://github.com/streamlink/streamlink?tab=readme-ov-file
{
  pkgs,
  config,
  ...
}: {
  config.programs.streamlink = {
    enable = true;
  };
}
