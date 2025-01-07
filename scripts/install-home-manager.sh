#!/bin/bash

#echo "experimental-features = nix-command flakes" > /etc/nix/nix.conf
#echo 'experimental-features = nix-command flakes' | sudo tee /etc/nix/nix.conf
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install


if [ -d $HOME/.config/nix/ ] || mkdir -p $HOME/.config/nix
echo 'experimental-features = nix-command flakes' | tee $HOME/.config/nix/nix.conf

if [ -d $HOME/.config/nixpkgs/ ] || mkdir -p $HOME/.config/nix
echo '{ allowUnfree = true; }' | tee $HOME/.config/nixpkgs/config.nix
