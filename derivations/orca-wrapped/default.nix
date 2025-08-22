{pkgs, ...}:

  # Here is a way with overlays, rebuilding takes too long so rather not apparently
  # We add our overlays for packages here
  # nixpkgs.overlays = [
  #   (self: super: {
  #     orca-slicer = super.orca-slicer.overrideAttrs (_: {
  #       # Allows it to make full use of my cores
  #       enableParallelBuilding = true;
  #       enableParallelChecking = true;
  #
  #       # The following is to add the suggestions from
  #       # https://github.com/NixOS/nixpkgs/issues/345590
  #       # https://discourse.nixos.org/t/allow-orca-slicer-bambu-slicer-to-work-with-nvidia-drivers/65001
  #       # orca-slicer was not running within hyprland using my nvidia drivers, kept getting seg errors
  #       preFixup = ''
  #         gappsWrapperArgs+=(
  #           --prefix LD_LIBRARY_PATH : "$out/lib:${
  #             super.lib.makeLibraryPath [
  #               super.glew
  #             ]
  #           }"
  #           --set WEBKIT_DISABLE_COMPOSITING_MODE 1
  #           --set __GLX_VENDOR_LIBRARY_NAME=mesa
  #           --set __EGL_VENDOR_LIBRARY_FILENAMES=${super.mesa.drivers}/share/glvnd/egl_vendor.d/50_mesa.json
  #           --set MESA_LOADER_DRIVER_OVERRIDE=zink
  #           --set GALLIUM_DRIVER=zink
  #           --set WEBKIT_DISABLE_DMABUF_RENDERER=1
  #         )
  #       '';
  #     });
  #   })
  # ];

  pkgs.makeDesktopItem {
    name = "orca-slicer-mesa";
    desktopName = "OrcaSlicer (MESA)";
    genericName = "3D Printing Software";
    icon = "OrcaSlicer";
    exec = "env __GLX_VENDOR_LIBRARY_NAME=mesa __EGL_VENDOR_LIBRARY_FILENAMES=${pkgs.mesa}/share/glvnd/egl_vendor.d/50_mesa.json MESA_LOADER_DRIVER_OVERRIDE=zink GALLIUM_DRIVER=zink WEBKIT_DISABLE_DMABUF_RENDERER=1 WEBKIT_DISABLE_COMPOSITING_MODE=1 ${pkgs.orca-slicer}/bin/orca-slicer %U";
    terminal = false;
    type = "Application";
    mimeTypes = [
      "model/stl"
      "model/3mf"
      "application/vnd.ms-3mfdocument"
      "application/prs.wavefront-obj"
      "application/x-amf"
      "x-scheme-handler/orcaslicer"
    ];
    categories = [ "Graphics" "3DGraphics" "Engineering" ];
    keywords = [ "3D" "Printing" "Slicer" "slice" "3D" "printer" "convert" "gcode" "stl" "obj" "amf" "SLA" ];
    startupNotify = false;
    startupWMClass = "orca-slicer";
}
