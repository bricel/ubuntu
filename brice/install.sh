#!/bin/bash

# Update and Upgrade APT
sudo apt update && sudo apt upgrade -y

# Install APT packages
while IFS= read -r package; do
    sudo apt install -y "$package"
done < apt-packages.txt

# Ensure snap is installed and install Snap packages
sudo apt install snapd -y
while IFS= read -r package; do
    sudo snap install "$package"
done < snap-packages.txt

# Check for Flatpak and install Flatpak packages
if command -v flatpak &>/dev/null; then
    while IFS= read -r package; do
        flatpak install -y "$package"
    done < flatpak-packages.txt
else
    echo "Flatpak is not installed, skipping Flatpak packages."
fi
