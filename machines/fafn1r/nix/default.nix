# For nixOS specific imports
{inputs, ...}: {
  # Pin cache.nixos.org to a nearby Fastly POP (ISP anycast misroutes to distant POPs)
  networking.extraHosts = ''
    151.101.65.91 cache.nixos.org
  '';

  imports = [
    # Hardware declarations
    ./hardware-configuration.nix
    # Import nixOS settings
    ../../../nix
    # Settings
    ../settings
    # I also for this one want to import virtualization
    ../../../nix/virtualization
    # Rather import themes here
    ../../../themes
    # Boot settings
    ./boot.nix
    # Sops secrets
    ./sops.nix
  ];
}
