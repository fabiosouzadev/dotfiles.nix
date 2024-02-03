default: 
    @just --list 
    
############################################################################
#
#  NixOs Commands
#
############################################################################

get-config-notezapay:
   nixos-generate-config --show-hardware-config > lib/nixos/hardware/notezapay/hardware-configuration.nix 

test:
  nixos-rebuild test --flake .#virt-manager --use-remote-sudo

deploy:
  nixos-rebuild switch --flake .#virt-manager --use-remote-sudo

test-notezapay:
  nixos-rebuild test --flake .#notezapay --use-remote-sudo --show-trace --verbose

deploy-notezapay:
  nixos-rebuild switch --flake .#notezapay --use-remote-sudo --show-trace --verbose

debug:
  nixos-rebuild switch --flake .#nixos-test --use-remote-sudo --show-trace --verbose

up:
  nix flake update

# Update specific input
# usage: make upp i=home-manager
upp:
  nix flake lock --update-input $(i)

history:
  nix profile history --profile /nix/var/nix/profiles/system

repl:
  nix repl -f flake:nixpkgs

gc:
  # garbage collect all unused nix store entries
  sudo nix profile wipe-history --profile /nix/var/nix/profiles/system  --older-than 7d
  sudo nix store gc --debug
  sudo nix-collect-garbage --delete-old
  home-manager expire-generations "-7 days"

clean:
  # remove all generations older than 7 days
  sudo nix profile wipe-history --profile /nix/var/nix/profiles/system  --older-than 7d

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

