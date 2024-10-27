{
  lib,
  rustPlatform,
  fetchFromGitHub,
  pkg-config,
  openssl,
  stdenv,
  darwin,
alsa-lib,
...
}:

rustPlatform.buildRustPackage rec {
  pname = "lowfi";
  version = "1.5.2";

  src = fetchFromGitHub {
    owner = "talwat";
    repo = "lowfi";
    rev = version;
    hash = "sha256-+LO1hyQUPcRM3MCtUsYBvFqXHXfOOSb1X543zRAVj/A=";
  };

  cargoHash = "sha256-AkpM3Qd9w51GFXxT/qoAP84H3moXlyY7NcaaASbzeQE=";

  nativeBuildInputs = [
    pkg-config
    rustPlatform.bindgenHook
  ];

  buildInputs = [
    openssl
  ] ++ lib.optionals stdenv.isDarwin [
    darwin.apple_sdk.frameworks.CoreAudio
    darwin.apple_sdk.frameworks.Security
    darwin.apple_sdk.frameworks.SystemConfiguration
  ] ++ lib.optionals stdenv.isLinux [
    alsa-lib
  ];

  meta = {
    description = "An extremely simple lofi player";
    homepage = "https://github.com/talwat/lowfi";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ ];
    mainProgram = "lowfi";
  };
}
