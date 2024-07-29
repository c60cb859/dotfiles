#!/bin/bash

LOG_FILE=install.log

echo -e "[O] Install Hyprland packages"
sudo pacman -S --needed --noconfirm \
  hyprland \
  hyprlock \
  hypridle \
  brightnessctl \
  wofi \
  cliphist \
  waybar \
  slurp \
  &>> "$LOG_FILE"

echo -e "[O] Add user to groups"
sudo usermod -aG \
  video,seat \
  "$USER" \
  &>> "$LOG_FILE"

SERVICE="seatd"

if systemctl is-enabled --quiet "$SERVICE"; then
    echo "[O] $SERVICE is already enabled"
else
    # Enable the service
    sudo systemctl enable "$SERVICE" &>> "$LOG_FILE"
    echo "[O] Enabled $SERVICE"
fi

# Check if the service is active (running)
if systemctl is-active --quiet "$SERVICE"; then
    echo "[O] $SERVICE is already running"
else
    # Start the service
    sudo systemctl start "$SERVICE" &>> "$LOG_FILE"
    echo "[O] Started $SERVICE"
fi
