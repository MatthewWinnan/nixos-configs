{inputs, ...}: {
  config.programs.chromium = {
    enable = true;
    commandLineArgs = [
      "--enable-logging=stderr"
      "--ozone-platform-hint=wayland"
      "--gtk-version=4"
      "--ignore-gpu-blocklist"
      "--enable-features=TouchpadOverscrollHistoryNavigation"
      "--enable-wayland-ime"
    ];
    extensions = [
      {id = "dbepggeogbaibhgnhhndojpepiihcmeb";} # vimium
      {id = "eimadpbcbfnmbkopoojfekhnkhdbieeh";} # dark reader
      {id = "bgnkhhnnamicmpeenaelnjfhikgbkllg";} # adguard
      {
        # bypass paywalls
        id = "dcpihecpambacapedldabdbpakmachpb";
        updateUrl = "https://raw.githubusercontent.com/iamadamdev/bypass-paywalls-chrome/master/updates.xml";
      }
    ];
  };
}
