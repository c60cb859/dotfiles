#!/bin/bash

# Install the packages using pacman
sudo pacman -S --needed \
  alacritty \
  hyrland \
  firefox \
  brightnessctl \
  waybar

paru --assume-installed cargo \
  -S --needed \
  adwaita-dark \
  adwaita-qt5 \
  adwaita-qt6 \
  anyrun


GROUPS=("video" "seat")

for GROUP in "${GROUPS[@]}"; do
    # Check if the user is already in the group
    if id -nG "$USER" | grep -qw "$GROUP"; then
        echo "$USER is already a member of $GROUP"
    else
        # Add the user to the group
        sudo usermod -aG "$GROUP" "$USER"
        echo "Added $USER to $GROUP"
    fi
done

SERVICE="seatd"

if systemctl is-enabled --quiet "$SERVICE"; then
    echo "$SERVICE is already enabled"
else
    # Enable the service
    sudo systemctl enable "$SERVICE"
    echo "Enabled $SERVICE"
fi

# Check if the service is active (running)
if systemctl is-active --quiet "$SERVICE"; then
    echo "$SERVICE is already running"
else
    # Start the service
    sudo systemctl start "$SERVICE"
    echo "Started $SERVICE"
fi
