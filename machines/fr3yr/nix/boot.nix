# Raspberry Pi 4 boot configuration
# Uses extlinux bootloader (standard for Pi)
{
  # Use the extlinux boot loader for Raspberry Pi
  boot.loader.grub.enable = false;
  boot.loader.generic-extlinux-compatible.enable = true;

  # Kernel parameters for Pi 4
  boot.kernelParams = [
    "console=serial0,115200"
    "console=tty1"
  ];

  # Initial RAM disk configuration
  boot.initrd.availableKernelModules = [
    "usbhid"
    "usb_storage"
    "vc4"
    "pcie_brcmstb" # For USB boot
    "reset-raspberrypi" # Required for vl805 firmware to load
  ];
}
