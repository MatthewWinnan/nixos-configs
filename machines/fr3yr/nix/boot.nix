# Raspberry Pi 4 boot configuration
{ pkgs, ... }:
{
  boot = {
    # Use the Raspberry Pi 4 optimized kernel
    kernelPackages = pkgs.linuxKernel.packages.linux_rpi4;

    initrd.availableKernelModules = [
      "xhci_pci"
      "usbhid"
      "usb_storage"
      "vc4"
      "pcie_brcmstb" # For USB boot
      "reset-raspberrypi" # Required for vl805 firmware to load
    ];

    loader = {
      grub.enable = false;
      generic-extlinux-compatible.enable = true;
    };

    kernelParams = [
      "console=serial0,115200"
      "console=tty1"
    ];
  };
}
