{pkgs, ...}: {
  config = {
    services = {
      # This is actually super important for vscode, managed to get the popup screens to work after adding this.
      udev.packages = [pkgs.gnome-settings-daemon pkgs.libsigrok];
      gnome = {
        # Whether to enable gnome-keyring. This is usually necessary for storing
        # secrets for programming applications such as VSCode or GitHub desktop.
        # It is also optional to use google/nextcloud calendar.
        gnome-keyring.enable = true;
      };
    };
  };
}
