#!/bin/bash

echo -e "[O] Install desktop packages"
# Recommended fonts
sudo pacman -S --needed \
  noto-fonts \
  noto-fonts-cjk \
  noto-fonts-emoji \
  noto-fonts-extra

# Optional but highly recommended fonts
sudo pacman -S --needed \
  ttf-liberation \
  ttf-dejavu \
  ttf-roboto

sudo ln -s /usr/share/fontconfig/conf.avail/10-sub-pixel-rgb.conf /etc/fonts/conf.d/
sudo ln -s /usr/share/fontconfig/conf.avail/10-hinting-slight.conf /etc/fonts/conf.d/
sudo ln -s /usr/share/fontconfig/conf.avail/11-lcdfilter-default.conf /etc/fonts/conf.d/
sudo fc-cache -fv

sudo pacman -S --needed \
  alacritty \
  hyprland \
  firefox \
  brightnessctl \
  waybar

echo -e "[O] Install desktop AUR packages"
paru --assume-installed cargo \
  -S --needed --noconfirm \
  adwaita-dark \
  adwaita-qt5 \
  adwaita-qt6 \
  anyrun-git


echo -e "[O] Add user to groups"
sudo usermod -aG \
  video,seat \
  "$USER"

SERVICE="seatd"

if systemctl is-enabled --quiet "$SERVICE"; then
    echo "[0] $SERVICE is already enabled"
else
    # Enable the service
    sudo systemctl enable "$SERVICE"
    echo "[0] Enabled $SERVICE"
fi

# Check if the service is active (running)
if systemctl is-active --quiet "$SERVICE"; then
    echo "[0] $SERVICE is already running"
else
    # Start the service
    sudo systemctl start "$SERVICE"
    echo "[0] Started $SERVICE"
fi
