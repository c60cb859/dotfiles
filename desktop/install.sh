#!/bin/bash

LOG_FILE=install.log

echo -e "[O] Install fonts"
# Recommended fonts
sudo pacman -S --needed \
  noto-fonts \
  noto-fonts-cjk \
  noto-fonts-emoji \
  noto-fonts-extra \
  &>> "$LOG_FILE"

# Optional but highly recommended fonts
sudo pacman -S --needed \
  ttf-liberation \
  ttf-dejavu \
  ttf-roboto \
  &>> "$LOG_FILE"


paru -S --needed ttf-symbola &>> "$LOG_FILE"

sudo fc-cache -fv &>> "$LOG_FILE"

echo -e "[O] Install desktop packages"
sudo pacman -S --needed \
  alacritty \
  polkit \
  firefox \
  &>> "$LOG_FILE"

echo -e "[O] Install desktop AUR packages"
paru --assume-installed cargo \
  -S --needed --noconfirm \
  adwaita-dark \
  adwaita-qt5 \
  adwaita-qt6 \
  &>> "$LOG_FILE"
