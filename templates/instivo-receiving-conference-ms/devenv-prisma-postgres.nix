{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: {
  # https://devenv.sh/basics/
  env = {
    GREET = "devenv";
    SHELL = "${pkgs.zsh}/bin/zsh";
    DATABASE_URL = "postgresql://fabiosouzadev:123@localhost:5432/receiving-conference?schema=public";
    PRISMA_MIGRATION_ENGINE_BINARY = "${pkgs.prisma-engines}/bin/migration-engine";
    PRISMA_QUERY_ENGINE_BINARY = "${pkgs.prisma-engines}/bin/query-engine";
    PRISMA_QUERY_ENGINE_LIBRARY = "${pkgs.prisma-engines}/lib/libquery_engine.node";
    PRISMA_INTROSPECTION_ENGINE_BINARY = "${pkgs.prisma-engines}/bin/introspection-engine";
    PRISMA_FMT_BINARY = "${pkgs.prisma-engines}/bin/prisma-fmt";
  };

  # https://devenv.sh/packages/
  packages = with pkgs; [
    openssl
    nodejs
    postgresql
    nodePackages.npm
    nodePackages.prisma
  ];

  # https://devenv.sh/languages/
  # languages.rust.enable = true;
  languages.javascript = {
    enable = true;
    npm = {
      enable = true;
      install.enable = true;
    };
  };

  # https://devenv.sh/processes/
  # processes.cargo-watch.exec = "cargo-watch";
  process.managers.process-compose.settings = {
    availability = {
      backoff_seconds = 2;
      max_restarts = 2;
      restart = "on_failure";
    };
  };

  # https://devenv.sh/services/
  services.postgres = {
    enable = true;
    listen_addresses = "*";
    initialDatabases = [
      {
        name = "receiving-conference";
      }
    ];
    # initialScript = builtins.readFile ./data/dump.sql;
  };
  # services.mongodb = {
  #   enable = true;
  #   initDatabaseUsername = "mongouser";
  #   initDatabasePassword = "secret";
  # };
  services.adminer = {
    enable = true;
    listen = "127.0.0.1:8081";
  };

  # https://devenv.sh/scripts/
  # scripts.hello.exec = ''
  #   echo hello from $GREET
  # ''

  # enterShell = ''
  #   hello
  #   git --version
  # '';

  scripts = {
    start = {
      description = "Starts the development server";
      exec = "npm run start:dev";
    };
    migrate = {
      description = "Runs prisma migrate dev";
      exec = "prisma migrate dev";
    };
    generate = {
      description = "Runs prisma generate";
      exec = "prisma generate";
    };
  };
  enterShell = ''
    export NODE_PATH=$PWD/.nix-node
    export PATH=$NODE_PATH/bin:$PATH
    if [ ! -d node_modules ]; then
      mkdir -p .nix-node
      npm config set prefix $NODE_PATH
      npm install
      prisma generate
    fi
  '';

  # https://devenv.sh/tasks/
  # tasks = {
  #   "myproj:setup".exec = "npm run start:dev";
  #   "devenv:enterShell".after = ["myproj:setup"];
  # };

  # https://devenv.sh/tests/
  enterTest = ''
    echo "Running tests"
    git --version | grep --color=auto "${pkgs.git.version}"
  '';

  # https://devenv.sh/git-hooks/
  # git-hooks.hooks.shellcheck.enable = true;

  # See full reference at https://devenv.sh/reference/options/
  dotenv.enable = true;
}
