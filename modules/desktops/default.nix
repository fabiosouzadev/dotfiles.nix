[
  ./user.nix
  ./common.nix
  ./fonts.nix
  ./i3.nix
  ./polkit.nix
]
  ++ import (./terminals)
  ++ import (../virtualization)
