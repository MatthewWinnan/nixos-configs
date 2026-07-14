{...}: {
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
  # preferStaticEmulators registers binfmt with the F (fix-binary) flag,
  # which pre-loads the interpreter so it works inside containers/chroots
  # without needing /run/binfmt accessible from inside them.
  boot.binfmt.preferStaticEmulators = true;
}
