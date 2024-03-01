{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
 buildInputs = [ 
 	pkgs.python311
	pkgs.python311Packages.pip
	pkgs.python311Packages.virtualenv
	pkgs.python311Packages.setuptools
	pkgs.python311Packages.wheel
 ]; # Python version and other dependencies
}
