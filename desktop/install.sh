#!/bin/bash

PACKAGES_JSON='{{ desktop_packages }}'
# Remove the brackets
PACKAGES=${PACKAGES_JSON:1:-1}
# Remove the quotes and commas
PACKAGES=${PACKAGES//\"/}
PACKAGES=${PACKAGES//,/}
# Install the packages using pacman
sudo pacman -S --needed "$PACKAGES"
