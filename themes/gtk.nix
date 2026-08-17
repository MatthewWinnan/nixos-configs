{pkgs, lib, ...}: {
  gtk = {
    enable = true;

    # Force dark variant — Stylix sets adw-gtk3 (light) even with polarity = "dark"
    theme = {
      name = lib.mkForce "adw-gtk3-dark";
      package = lib.mkForce pkgs.adw-gtk3;
    };
  };
}
