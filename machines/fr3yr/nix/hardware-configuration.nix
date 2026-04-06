# Hardware configuration for Raspberry Pi 4
# Most hardware setup is handled by nixos-hardware.nixosModules.raspberry-pi-4
{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  # File systems - adjust labels after installation
  # Root partition
  fileSystems."/" = {
    device = "/dev/disk/by-label/NIXOS_SD";
    fsType = "ext4";
  };

  # Boot partition
  fileSystems."/boot" = {
    device = "/dev/disk/by-label/NIXOS_BOOT";
    fsType = "vfat";
  };

  # No swap by default - can add if needed
  swapDevices = [ ];

  # Firmware for wireless, bluetooth, etc.
  hardware.enableRedistributableFirmware = true;

  # Set platform
  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
}
