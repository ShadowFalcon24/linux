#!/usr/bin/env bash
set -e

# Change directory to /etc/nixos/
pushd /etc/nixos/

# Read what we want to do
operation=${1:-switch}

# Read current target configuration
target=$(<target.txt)

# Run Alejandra quietly
alejandra .

# Show changes in *.nix files with zero context lines
git diff -U0 *.nix

# Prompt for changes
while true; do
    read -p "What have you changed?: " reason

    # Prompt for confirmation
    read -p "Commit message: $reason"$'\n'"Is this message correct? [y/n/c]: " confirm
    case $confirm in
        [yY]* )
            break;;
        [nN]* )
            echo "Please enter the corrected message."
            continue;;
        [cC]* )
            echo "Aborting commit."
            exit 1;;
        * )
            echo "Please answer 'y', 'n', or 'c'.";;
    esac
done

# Inform about NixOS rebuilding
echo "NixOS Rebuilding..."

# Perform NixOS switch, logging any errors
sudo nixos-rebuild $operation --flake /etc/nixos#$target

# Obtain the current generation
gen=$(nixos-rebuild list-generations | grep current | awk '{print "Generation", $1, "\nDate:", $3, $4, "\nSystem:", $5, "\nKernel:", $6}')

# Commit changes with the current generation as the commit message
git commit -am "$reason"$'\n'"$gen"

# Return to the previous directory
popd
