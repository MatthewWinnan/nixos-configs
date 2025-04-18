# DOCS -> https://github.com/talwat/lowfi
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
  version = "1.6.4-dev";

  src = fetchFromGitHub {
    owner = "talwat";
    repo = "lowfi";
    rev = version;
    hash = "sha256-6wrozXFLek08/FlhaLaOfmgpJGTE8sWBRWG2w7Dz1oU=";
  };

  cargoHash = "sha256-qywhf9lF7cocPVeOJEfKdF+9Ho7lP2pd6T1t1EJg9qc=";
  useFetchCargoVendor = true;

  nativeBuildInputs = [
    pkg-config
    rustPlatform.bindgenHook
  ];

  buildInputs =
    [
      openssl
    ]
    ++ lib.optionals stdenv.isDarwin [
      darwin.apple_sdk.frameworks.CoreAudio
      darwin.apple_sdk.frameworks.Security
      darwin.apple_sdk.frameworks.SystemConfiguration
    ]
    ++ lib.optionals stdenv.isLinux [
      alsa-lib
    ];

  meta = {
    description = "An extremely simple lofi player";
    homepage = "https://github.com/talwat/lowfi";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [];
    mainProgram = "lowfi";
  };
}
