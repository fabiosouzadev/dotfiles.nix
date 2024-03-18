[
  ./user.nix
  ./common.nix
  ./fonts.nix
  ./i3.nix
  ./polkit.nix
  ./spotify.nix
]
  ++ import (./terminals)
  ++ import (../virtualisation)
