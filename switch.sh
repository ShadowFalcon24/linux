#!/usr/bin/env bash
set -e

# Change directory to /etc/nixos/
pushd /etc/nixos/

target=$(<target.txt)

echo "Switching to this configuration..."
sudo nixos-rebuild boot --flake /etc/nixos#$target
sudo nix-collect-garbage -d
echo "Please reboot the system to activate the new configuration"

# Return to the previous directory
popd