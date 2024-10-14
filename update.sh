#!/usr/bin/env bash
set -e

# Change directory to /etc/nixos/
pushd /etc/nixos/

echo "Updating packages..."
nix flake update

echo "Rebuilding NixOS..."
./rebuild.sh "$@"

# Return to the previous directory
popd