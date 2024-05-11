#!/usr/bin/env bash
set -e

# Change directory to /etc/nixos/
pushd /etc/nixos/

# Read current target configuration
target=$(<target.txt)

# Run Alejandra quietly
alejandra . &>/dev/null

# Show changes in *.nix files with zero context lines
git diff -U0 *.nix

# Inform about NixOS rebuilding
echo "NixOS Rebuilding..."

# Perform NixOS switch, logging any errors
sudo nixos-rebuild switch --flake /etc/nixos#$target

# Obtain the current generation
gen=$(nixos-rebuild list-generations | grep current | awk '{print "Generation", $1, "\nDate:", $3, $4, "\nSystem:", $5, "\nKernel:", $6}')

# Commit changes with the current generation as the commit message
git commit -am "$gen"

# Return to the previous directory
popd
