default: 
    @just --list

############################################################################
#
#  NixOs Commands
#
###########################################################################

get-config host:
  sudo nixos-generate-config --dir ./nixos/hosts/{{ host }} 

get-submodules:
  git submodule update --init --recursive zapay
  cp -r zapay/aws  ~/.aws

test host:
  #just get-config {{ host }}
  nixos-rebuild test --flake .#{{ host }}  --impure --use-remote-sudo --show-trace --print-build-logs --verbose

test-mac host:
  nix run nix-darwin -- test --flake .#{{ host }} --impure --show-trace --print-build-logs --verbose

build host:
  #just get-config {{host}}
  nixos-rebuild switch --flake .#{{ host }} --impure --use-remote-sudo --show-trace --print-build-logs --verbose

build-macos host:
  nix run nix-darwin -- switch --flake .#{{ host }} --impure --show-trace --print-build-logs --verbose

build-and-update host:
  just get-config {{host}}
  just up
  nixos-rebuild switch --flake .#{{ host }} --impure --use-remote-sudo --show-trace --print-build-logs --verbose

rebuild-boot host:
  #just get-config {{host}}
  nixos-rebuild --install-bootloader boot --flake .#{{ host }} --use-remote-sudo --show-trace --print-build-logs --verbose

up:
  nix flake update

# Update specific input
# usage: make upp i=home-manager
upp:
  nix flake update $(i)

up-home:
  nix flake lock home-manager

update-secrets:
  nix flake lock --update-input mysecrets

update-nvim:
  nix flake lock --update-input neovim-flake

clean:
  # remove all generations older than 7 days
  sudo nix profile wipe-history --profile /nix/var/nix/profiles/system  --older-than 7d

gc:
  # garbage collect all unused nix store entries
  sudo nix-collect-garbage --delete-old

# clean-packages:
#   rm -rf ~/.cache/nix/
#   rm -f flake.lock


