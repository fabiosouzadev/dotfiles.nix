{ pkgs
, inputs
, system
, ...
}:
let
  awsvpnclient = inputs.awsvpnclient;
in
{
  environment.systemPackages = [ awsvpnclient ];
  nixpkgs.overlays = [
    (final: prev: {
      awsvpnclient = awsvpnclient.packages.${system}.awsvpnclient;
    })
  ];
}
