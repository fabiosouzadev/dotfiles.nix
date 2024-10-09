# save this as shell.nix
{pkgs ? import <nixpkgs> {}}:
pkgs.mkShellNoCC {
  packages = with pkgs; [
    (
      python3.withPackages (
        ps: [
          ps.pip
        ]
      )
    )
    bash
    curl
    jq
  ];
}
