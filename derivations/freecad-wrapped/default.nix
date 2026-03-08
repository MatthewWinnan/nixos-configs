{ pkgs, ... }:
pkgs.makeDesktopItem {
  name = "freecad-mesa";
  desktopName = "FreeCAD (MESA)";
  genericName = "CAD Application";
  icon = "freecad";
  exec = "env __GLX_VENDOR_LIBRARY_NAME=mesa __EGL_VENDOR_LIBRARY_FILENAMES=${pkgs.mesa}/share/glvnd/egl_vendor.d/50_mesa.json MESA_LOADER_DRIVER_OVERRIDE=zink GALLIUM_DRIVER=zink WEBKIT_DISABLE_DMABUF_RENDERER=1 WEBKIT_DISABLE_COMPOSITING_MODE=1 ${pkgs.freecad-wayland}/bin/FreeCAD %F";
  terminal = false;
  type = "Application";
  mimeTypes = [
    "application/x-extension-fcstd"
    "application/x-freecad"
  ];
  categories = [
    "Graphics"
    "Science"
    "Engineering"
  ];
  keywords = [
    "CAD"
    "3D"
    "Modeling"
    "Engineering"
    "Design"
    "Parametric"
  ];
  startupNotify = false;
  startupWMClass = "FreeCAD";
}
