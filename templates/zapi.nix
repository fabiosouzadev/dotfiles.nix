{pkgs ? import <nixpkgs> {}}: let
  nix-pre-commit-hooks = import (builtins.fetchTarball "https://github.com/cachix/git-hooks.nix/tarball/master");

  pyPackages = with pkgs.python3Packages; [
    python
    venvShellHook
    pip
    psycopg2
    setuptools
    pycurl
    lxml
    cffi
    pillow
    isort
    wheel
    poetry-core
    pre-commit-hooks
  ];
in
  pkgs.mkShell {
    venvDir = "./.venv";
    buildInputs = [
      pyPackages
      pkgs.cowsay
      pkgs.postgresql
      pkgs.openssl
      pkgs.curl
      pkgs.libxml2
      pkgs.libxslt
      pkgs.zlib
      pkgs.pre-commit
      pkgs.isort
      pkgs.poetry
      pkgs.git
      pkgs.wget
    ];

    postVenvCreation = ''
      unset SOURCE_DATE_EPOCH
      pip install -r requirements.txt
    '';

    postShellHook = ''
      unset SOURCE_DATE_EPOCH
    '';
  }
