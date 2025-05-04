# use:
# `nix develop .#nodejs -c $SHELL`
{
  description = "Node Flake Shells";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {inherit system;};
  in {
    devShells.x86_64-linux.nodejs = pkgs.mkShell {
      buildInputs = with pkgs; [
        openssl
        nodejs
        nodePackages.npm
        prisma
      ];
      shellHook = ''
        mkdir -p .nix-node
        export NODE_PATH=$PWD/.nix-node
        export PATH=$NODE_PATH/bin:$PATH
        npm config set prefix $NODE_PATH
         export PRISMA_SCHEMA_ENGINE_BINARY="${pkgs.prisma-engines}/bin/schema-engine"
         export PRISMA_QUERY_ENGINE_BINARY="${pkgs.prisma-engines}/bin/query-engine"
         export PRISMA_QUERY_ENGINE_LIBRARY="${pkgs.prisma-engines}/lib/libquery_engine.node"
         export PRISMA_FMT_BINARY="${pkgs.prisma-engines}/bin/prisma-fmt"
      '';
    };
  };
}
