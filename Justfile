default: 
    @just --list

############################################################################
#
#  NixOs Commands
#
###########################################################################

get-config host:
  cp /etc/nixos/hardware-configuration.nix hosts/{{ host }}/hardware-configuration.nix 

get-submodules:
  git submodule update --init --recursive zapay
  cp -r zapay/aws  ~/.aws

test host:
  just get-config {{host}}
  sudo nixos-rebuild test --flake .#{{ host }} --show-trace -L -v

build host:
  just get-config {{host}}
  sudo nixos-rebuild switch --flake .#{{ host }} --show-trace

clean-packages:
  rm -rf ~/.cache/nix/
  rm -f flake.lock
