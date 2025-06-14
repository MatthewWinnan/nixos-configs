{
  lib,
  rustPlatform,
  fetchFromGitHub,
}:

rustPlatform.buildRustPackage rec {
  pname = "basalt";
  version = "0.6.1";

  src = fetchFromGitHub {
    owner = "erikjuhani";
    repo = "basalt";
    rev = "basalt/v${version}";
    hash = "sha256-NQ12Q8IAcPLOTRCnUOko91QzoiFl8QPdchcpxdNKHLs=";
  };

  cargoLock = {
    lockFile = ./Cargo.lock;
  };

  meta = {
    description = "TUI Application to manage Obsidian notes directly from the terminal";
    homepage = "https://github.com/erikjuhani/basalt";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ ];
    mainProgram = "basalt";
  };
}
