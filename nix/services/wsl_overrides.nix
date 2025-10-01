# Some sensible overrides for WSL since some of these just don't exist
{
  # Disable systemd units that don't make sense on WSL
  systemd = {
    services = {
      "serial-getty@ttyS0".enable = false;
      "serial-getty@hvc0".enable = false;
      "getty@tty1".enable = false;
      "autovt@".enable = false;
      firewall.enable = false;
      systemd-resolved.enable = false;
      systemd-udevd.enable = false;
    };
  # Don't allow emergency mode, because we don't have a console.
    enableEmergencyMode = false;
  };
}
