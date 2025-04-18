{
  lib,
  rustPlatform,
  fetchFromGitHub,
  gpgme,
  libgpg-error,
  pkg-config,
  bzip2,
  zstd,
  stdenv,
  darwin,
}:
rustPlatform.buildRustPackage rec {
  pname = "himalaya";
  version = "latest";

  src = fetchFromGitHub {
    owner = "pimalaya";
    repo = "himalaya";
    rev = version;
    hash = "sha256-NrWBg0sjaz/uLsNs8/T4MkUgHOUvAWRix1O5usKsw6o=";
  };

  cargoHash = "sha256-Jo2fI6N9nY2DhSfODOSfQjolhqtgspwN8evzghsrw+k=";

  nativeBuildInputs = [
    gpgme
    libgpg-error
    pkg-config
  ];

  buildInputs =
    [
      bzip2
      gpgme
      libgpg-error
      zstd
    ]
    ++ lib.optionals stdenv.isDarwin [
      darwin.apple_sdk.frameworks.Security
      darwin.apple_sdk.frameworks.SystemConfiguration
    ];

  env = {
    ZSTD_SYS_USE_PKG_CONFIG = true;
  };

  meta = {
    description = "CLI to manage emails";
    homepage = "https://github.com/pimalaya/himalaya";
    changelog = "https://github.com/pimalaya/himalaya/blob/${src.rev}/CHANGELOG.md";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [];
    mainProgram = "himalaya";
  };
}
