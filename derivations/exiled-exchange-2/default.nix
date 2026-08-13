# DOCS -> https://github.com/Kvan7/Exiled-Exchange-2
# PoE2 price-check overlay (Ctrl+C on an item → price check)
# Linux guide -> https://exiled-exchange2.com/blog/exiled-exchange-2-linux/
# NOTE: PoE2 must be in Windowed or Windowed Fullscreen — Exclusive Fullscreen breaks the overlay.
# NOTE: ELECTRON_OZONE_PLATFORM_HINT=auto enables native Wayland; falls back to XWayland if unset.
{
  lib,
  appimageTools,
  fetchurl,
  makeWrapper,
}:
let
  appimage = appimageTools.wrapType2 {
    pname = "exiled-exchange-2";
    version = "0.15.8";

    src = fetchurl {
      url = "https://github.com/Kvan7/Exiled-Exchange-2/releases/download/v0.15.8/Exiled-Exchange-2-0.15.8.AppImage";
      hash = "sha256-xmEvKJkRFJokzOa/6qRqT4+QKfnfjIoAfqP+oDqyxH8=";
    };

    meta = {
      description = "Path of Exile 2 price-check overlay (fork of Awakened PoE Trade)";
      homepage = "https://github.com/Kvan7/Exiled-Exchange-2";
      license = lib.licenses.mit;
      platforms = ["x86_64-linux"];
      mainProgram = "exiled-exchange-2";
    };
  };
in
  appimage.overrideAttrs (old: {
    nativeBuildInputs = (old.nativeBuildInputs or []) ++ [makeWrapper];
    postInstall = (old.postInstall or "") + ''
      wrapProgram $out/bin/exiled-exchange-2 \
        --set ELECTRON_OZONE_PLATFORM_HINT auto \
        --add-flags "--no-sandbox"
    '';
  })
