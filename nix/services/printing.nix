# Following advice from https://discourse.nixos.org/t/newly-announced-vulnerabilities-in-cups/52771
# In general I am using the patch https://github.com/NixOS/nixpkgs/pull/344748 so should be fine
# Other suggestions https://discourse.nixos.org/t/cups-cups-filters-and-libppd-security-issues/52780
{inputs, ...}: {
  services.printing = {
    enable = false;
    startWhenNeeded = false;
    browsing = false;
    browsed.enable = false;
  };
  systemd.services = {
    cups-browsed.enable = false;
  };
}
