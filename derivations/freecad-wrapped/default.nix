{ pkgs, ... }:

pkgs.makeDesktopItem {
  name = "freecad-wayland-mesa";
  desktopName = "FreeCAD (MESA)";
  genericName = "3D Parametric Modeler";
  icon = "freecad";
  exec = "env __GLX_VENDOR_LIBRARY_NAME=mesa __EGL_VENDOR_LIBRARY_FILENAMES=${pkgs.mesa}/share/glvnd/egl_vendor.d/50_mesa.json MESA_LOADER_DRIVER_OVERRIDE=zink GALLIUM_DRIVER=zink WEBKIT_DISABLE_DMABUF_RENDERER=1 WEBKIT_DISABLE_COMPOSITING_MODE=1 ${pkgs.freecad-wayland}/bin/freecad-wayland %U";
  terminal = false;
  type = "Application";

  mimeTypes = [
    "application/x-freecad"
    "application/x-freecad-document"
    "application/x-extension-fcstd"
    "application/x-extension-fcstd1"
  ];

  categories = [ "Graphics" "Engineering" "Science" ];

  keywords = [ "CAD" "3D" "Modeling" "Parametric" "Design" "Simulation" "Drafting" "CAM" "FEM" "Rendering"
  ];

  startupNotify = false;
  startupWMClass = "freecad";
}

