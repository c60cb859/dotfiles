#!/bin/bash

echo -e "[O] Install fonts"
# Recommended fonts
sudo pacman -S --needed --noconfirm \
  noto-fonts \
  noto-fonts-cjk \
  noto-fonts-emoji \
  noto-fonts-extra

# Optional but highly recommended fonts
sudo pacman -S --needed --noconfirm \
  ttf-liberation \
  ttf-dejavu \
  ttf-roboto


paru -S --needed ttf-symbola

sudo fc-cache -fv

echo -e "[O] Install desktop packages"
sudo pacman -S --needed --noconfirm \
  alacritty \
  polkit \
  firefox

echo -e "[O] Install desktop AUR packages"
paru --assume-installed cargo \
  -S --needed --noconfirm \
  adwaita-dark \
  adwaita-qt5 \
  adwaita-qt6 \
  tesseract-data-eng \
  tesseract-data-dan \
  zathura-pdf-mupdf
