{
  boot = {
    loader = {
      efi = {canTouchEfiVariables = true;};
      grub = {
        enable = true;
        enableCryptodisk = true;
        device = "/dev/sda";
      };
    };
  };
}
