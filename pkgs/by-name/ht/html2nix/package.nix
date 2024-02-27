{ fetchFromGitHub, lib, python3 }: python3.pkgs.buildPythonApplication rec {
  pname = "html2nix";
  version = "0.0.1";
  # Set python build type.
  pyproject = true;

  src = fetchFromGitHub {
    owner = "ReedClanton";
    repo = "${pname}";
    rev = "v${version}";
    hash = "sha256-J0qEBS2I/h1zwf790AvZG0Bqe44YIgc1tgiFm8U41nk=";
  };

  # Build time dependencies.
  nativeBuildInputs = with python3.pkgs; [
    setuptools
  ];

  # Run time dependencies.
  buildInputs = with python3.pkgs; [
    # Using my fork.
    (buildPythonPackage rec {
      pname = "NetscapeBookmarksFileParser";
      version = "1.2";
      src = fetchFromGitHub {
        owner = "ReedClanton";
        repo = "Netscape-Bookmarks-File-Parser";
        rev = "v${version}";
        hash = "sha256-b4AFTHNMv0aMy25URe22cIAZvAL3pkP0oas//SMWCHY=";
      };
    })
  ];

  # Un-comment once tests are written.
  doCheck = false;

  meta = with lib; {
    changelog = "https://github.com/ReedClanton/html2nix/blob/${version}/CHANGELOG.md";
    description = "Converts HTML files containing bookmarks to Nix syntax.";
    longDescritpion = ''
      Converts HTML files that contain bookmarks to Nix syntax. The HTML files are exported by
      browsers and should follow the Netscape Bookmarks "standard". The resulting Nix syntax is
      accepted by Home Manager via `programs.firefox.profiles.<profileName>.bookmarks`.
    '';
    homepage = "https://github.com/ReedClanton/html2nix";
    license = licenses.mit;
    mainProgram = "html2nix";
    maintainers = with maintainers; [
      ReedClanton
    ];
    # Same as Home Manager.
    platforms = platforms.unix;
  };
}

