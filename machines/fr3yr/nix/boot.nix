# Raspberry Pi 4 boot configuration
{pkgs, ...}: {
  boot = {
    # Use the Raspberry Pi 4 optimized kernel
    #
    # TODO: deprecated - emits "linux-rpi series will be removed in a future
    # release. Please change to use nixos-hardware." on every evaluation, and
    # will eventually disappear from nixpkgs entirely.
    #
    # The migration is to DELETE this line. nixos-hardware's raspberry-pi-4
    # module is already imported (machines/default.nix) and sets kernelPackages
    # itself with lib.mkDefault, so this assignment is what overrides it:
    #
    #   kernelPackages = lib.mkDefault (
    #     pkgs.linuxPackagesFor (pkgs.callPackage ../common/kernel.nix { rpiVersion = 4; })
    #   );
    #
    # That builds linux-rpi from the raspberrypi/linux tree with
    # bcm2711_defconfig - the same vendor kernel lineage, just maintained. As
    # of nixos-hardware 2dda192 it resolves to linux-rpi-6.18.39-stable_20260724.
    #
    # Deferred deliberately: swapping the kernel on a Pi needs physical access
    # to the SD card if it fails to boot. Do it when you are at the machine,
    # with the previous generation kept in the extlinux menu to roll back to.
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
