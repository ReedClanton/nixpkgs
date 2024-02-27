{ fetchFromGitHub, lib, python3 }:
let
  version = "0.0.1";
in python3.pkgs.buildPythonApplication {
  pname = "html2nix";
  inherit version;
  format = "pyproject";

  # Switch to use `fetchFromGitHub` for production.
  src = fetchFromGitHub {
    owner = "ReedClanton";
    repo = "html2nix";
    rev = "v${version}";
    hash = "sha256-J0qEBS2I/h1zwf790AvZG0Bqe44YIgc1tgiFm8U41nk=";
  };

  nativeBuildInputs = [
    python3.pkgs.setuptools
  ];

  # TODO: Ensure this is import(s) needed to run tests.
#  nativeCheckInputs = [
#  ];

  meta = {
    changelog = "https://github.com/ReedClanton/html2nix/blob/${version}/CHANGELOG.md";
    description = "Converts HTML files containing bookmarks to Nix syntax.";
    longDescritpion = ''
      Converts HTML files that contain bookmarks to Nix syntax. The HTML files are exported by
      browsers and should follow the Netscape Bookmarks "standard". The resulting Nix syntax is
      accepted by Home Manager via `programs.firefox.profiles.<profileName>.bookmarks`.
    '';
    homepage = "https://github.com/ReedClanton/html2nix";
    license = lib.licenses.mit;
    mainProgram = "html2nix";
    maintainers = with lib.maintainers; [
      ReedClanton
    ];
    platforms = lib.platforms.linux ++ lib.platforms.unix;
  };
}

