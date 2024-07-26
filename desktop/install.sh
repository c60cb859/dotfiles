#!/bin/bash

PACKAGES_JSON='{{ desktop_packages }}'

PACKAGES=${PACKAGES_JSON:1:-1}
PACKAGES=${PACKAGES//,/}
packages_array=($PACKAGES)

# Install the packages using pacman
sudo pacman -S --needed "${packages_array[@]}"

paru -S --needed adwaita-dark adwaita-qt5-git adwaita-qt6-git
