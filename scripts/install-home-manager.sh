

#echo "experimental-features = nix-command flakes" > /etc/nix/nix.conf
echo 'experimental-features = nix-command flakes' | sudo tee /etc/nix/nix.conf
nix-shell '<home-manager>' -A install 
