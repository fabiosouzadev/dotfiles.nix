# use:
# `nix develop .#python36 -c $SHELL`
{
  description = "Python Flake Shells";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-22.11";
    # This bad boy is the last one to support 3.6
    nixpkgs-python36.url = "nixpkgs/nixos-21.05";
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = import inputs.nixpkgs {inherit system;};
    pkgs-python36 = import inputs.nixpkgs-python36 {inherit system;};
  in {
    devShells.x86_64-linux.python36 = pkgs.mkShell {
      nativeBuildInputs = with pkgs-python36; let
        devpython =
          python36.withPackages
          (packages: with packages; [pre-commit postgresql virtualenv pip setuptools wheel]);
      in [devpython];
    };
    devShells.x86_64-linux.python38 = pkgs.mkShell {
      nativeBuildInputs = with pkgs; let
        devpython =
          pkgs.python38.withPackages
          (packages: with packages; [virtualenv pip setuptools wheel]);
      in [devpython];
    };
    devShells.x86_64-linux.python39 = pkgs.mkShell {
      nativeBuildInputs = with pkgs; let
        devpython =
          pkgs.python39.withPackages
          (packages: with packages; [virtualenv pip setuptools wheel]);
      in [devpython];
    };
  };
}
