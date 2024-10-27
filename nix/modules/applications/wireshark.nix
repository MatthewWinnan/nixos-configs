{config, lib, ...}:{
 programs.wireshark.enable = config.systemSettings.profile == "work";
}
