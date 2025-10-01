# For the most part we let windows handle this no?
{config, ...}: {
  networking.hostName = config.systemSettings.hostname; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  # Firewall DOCS-> https://nixos.wiki/wiki/Firewall
  # Open ports in the firewall.
  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [
    5000
    465
    993
  ];
}
