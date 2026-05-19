{
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    blacklistedKernelModules = ["tpm_crb" "tpm_tis" "tpm"];
    #initrd.kernelModules = [ ];
    #kernelParams = [ ];
  };
}
