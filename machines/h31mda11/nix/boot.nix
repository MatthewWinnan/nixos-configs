{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.blacklistedKernelModules = ["tpm_crb" "tpm_tis" "tpm"];
  #boot.initrd.kernelModules = [ ];
  #boot.kernelParams = [ ];
}
