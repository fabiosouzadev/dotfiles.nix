{
  inputs,
  system,
  ...
}: {
  environment.systemPackages = [
    inputs.neovim-flake.packages.${system}.default
  ];
}
