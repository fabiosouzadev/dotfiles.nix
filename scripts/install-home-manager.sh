#!/bin/bash

#echo "experimental-features = nix-command flakes" > /etc/nix/nix.conf
#echo 'experimental-features = nix-command flakes' | sudo tee /etc/nix/nix.conf
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install
