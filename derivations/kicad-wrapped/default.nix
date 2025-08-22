
{ pkgs, ... }:

pkgs.makeDesktopItem {
  name = "kicad-mesa";
  desktopName = "KiCad (MESA)";
  genericName = "Electronic Design Automation Suite";
  icon = "kicad";
  exec = ''
    env __GLX_VENDOR_LIBRARY_NAME=mesa __EGL_VENDOR_LIBRARY_FILENAMES=${pkgs.mesa}/share/glvnd/egl_vendor.d/50_mesa.json MESA_LOADER_DRIVER_OVERRIDE=zink GALLIUM_DRIVER=zink WEBKIT_DISABLE_DMABUF_RENDERER=1 WEBKIT_DISABLE_COMPOSITING_MODE=1 ${pkgs.kicad}/bin/kicad %U
  '';
  terminal = false;
  type = "Application";

  # MIME types that KiCad handles
  mimeTypes = [
    "application/x-kicad-project"
    "application/x-kicad-schematic"
    "application/x-kicad-pcb"
    "application/x-kicad-symbol-library"
    "application/x-kicad-footprint-library"
    "application/x-kicad-bom"
    "application/x-kicad-layout"
    "application/x-kicad-netlist"
  ];

  # Must use valid freedesktop categories
  categories = [ "Development" "Engineering" "Graphics"
  ];

  # Helpful search keywords
  keywords = [ "EDA" "PCB" "Schematic" "Layout" "Circuit" "Board" "Electronics" "Design" "Hardware"
  ];

  startupNotify = false;
  startupWMClass = "kicad";
}

