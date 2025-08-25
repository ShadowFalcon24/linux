#!/usr/bin/env bash
set -e

# Change directory to /etc/nixos/
pushd /etc/nixos/

# Read what we want to do
operation=${1:-switch}

# Read current target configuration
target=$(<target.txt)

# Pull latest changes from upstream
echo "Pulling latest changes from upstream..."
git pull --autostash

# Run Alejandra quietly
echo "Formatting configuration..."
alejandra .

# If the file exists, update its selected wallpaper index with a random number from 0 to 10.
if [ -f users/shadow.nix ]; then
    # Generate a random number between 0 and 10.
    rand=$(( RANDOM % 2 ))
    echo "Updating selectedWallpaper index to ${rand} in users/shadow.nix"
    # Replace the digit after "selectedWallpaper = builtins.elemAt wallpapers " with the random number.
    sed -i "s/\(selectedWallpaper = builtins\.elemAt wallpapers \)[0-9]\{1,\}\(;\)/\1${rand}\2/" users/shadow.nix
fi

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
