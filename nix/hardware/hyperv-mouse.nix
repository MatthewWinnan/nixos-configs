{ config, lib, ... }:
lib.mkIf (config.systemSettings.profile == "work") {
  # The Hyper-V vmbus mouse is an absolute pointing device (ABS_X/ABS_Y
  # only, no REL_X/REL_Y). Hyprland 0.54+ broke click-and-drag for
  # absolute-only mice. Reclassifying it as a tablet makes Hyprland
  # route it through the tablet/absolute pointer path which handles
  # drag correctly.
  services.udev.extraRules = ''
    ATTRS{name}=="Microsoft Vmbus HID-compliant Mouse", ENV{ID_INPUT_MOUSE}="", ENV{ID_INPUT_TABLET}="1"
  '';
}
