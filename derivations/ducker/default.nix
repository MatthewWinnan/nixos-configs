{
  lib,
  rustPlatform,
  fetchFromGitHub,
  stdenv,
  darwin,
}:

rustPlatform.buildRustPackage rec {
  pname = "ducker";
  version = "0.4.1";

  src = fetchFromGitHub {
    owner = "robertpsoane";
    repo = "ducker";
    rev = "v${version}";
    hash = "sha256-S1FVV+sF8nGAnTJILjI1B8+EK5jfUW0MGzB1/uCwLXI=";
  };

  cargoHash = "sha256-bryAiaP+eed2K+f+/GTKPwrNemuu2IzAe+SR1hJBvUw=";

  buildInputs = lib.optionals stdenv.isDarwin [
    darwin.apple_sdk.frameworks.Security
  ];

  meta = {
    description = "A slightly quackers Docker TUI based on k9s";
    homepage = "https://github.com/robertpsoane/ducker";
    changelog = "https://github.com/robertpsoane/ducker/blob/${src.rev}/CHANGELOG.md";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ ];
    mainProgram = "ducker";
  };
}
