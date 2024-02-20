default: 
    @just --list

############################################################################
#
#  NixOs Commands
#
###########################################################################
get-config host:
   cp /etc/nixos/hardware-configuration.nix hosts/{{ host }}/hardware-configuration.nix 

test host:
     get-config {{ host }}
     sudo nixos-rebuild test --flake .#{{ host }} --show-trace --verbose

build host:
     sudo nixos-rebuild switch --flake .#{{ host }} --show-trace --verbose

############################################################################
#
#  Nvim
#
############################################################################

nvim-clean:
  rm -rf "$HOME/.config/nvim"

nvim-test: nvim-clean
  rsync -avz --copy-links --chmod=D2755,F744 configs/editors/nvim $"($env.HOME)/.config/nvim"

nvim-deploy: nvim-clean
  cp -r configs/editors/nvim "$HOME/.config/nvim"
