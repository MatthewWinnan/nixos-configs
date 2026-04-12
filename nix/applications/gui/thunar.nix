# Thunar GITHUB -> https://github.com/xfce-mirror/thunar
# Thunar NixOptions DOCS -> https://mynixos.com/nixpkgs/option/programs.thunar.enable
{pkgs, ...}: {
  # the thunar file manager
  programs.thunar = {
    enable = true;
    plugins = with pkgs; [
      thunar-archive-plugin
      thunar-media-tags-plugin
    ];
  };

  environment = {
    systemPackages = with pkgs; [
      # packages necessery for thunar thumbnails
      tumbler
      libgsf # odf files
      ffmpegthumbnailer
      kdePackages.ark # GUI archiver for thunar archive plugin
    ];
  };

  # thumbnail support on thunar
  services.tumbler.enable = true;
}
