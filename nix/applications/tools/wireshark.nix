{
  config,
  ...
}: {
  programs.wireshark.enable = config.systemSettings.profile == "work";
}
