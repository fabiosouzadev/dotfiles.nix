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
  #just get-config {{ host }}
  nixos-rebuild test --flake .#{{ host }} --use-remote-sudo --show-trace --verbose

build host:
  #just get-config {{host}}
  nixos-rebuild switch --flake .#{{ host }} --use-remote-sudo --show-trace --verbose

up:
  nix flake update

# Update specific input
# usage: make upp i=home-manager
upp:
  nix flake lock --update-input $(i)

clean:
  # remove all generations older than 7 days
  sudo nix profile wipe-history --profile /nix/var/nix/profiles/system  --older-than 7d

gc:
  # garbage collect all unused nix store entries
  sudo nix-collect-garbage --delete-old

# clean-packages:
#   rm -rf ~/.cache/nix/
#   rm -f flake.lock
