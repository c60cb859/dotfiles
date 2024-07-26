#!/bin/bash

PACKAGES_JSON='{{ system_packages }}'
# Remove the brackets
PACKAGES=${PACKAGES_JSON:1:-1}
# Remove the quotes and commas
PACKAGES=${PACKAGES//\"/}
PACKAGES=${PACKAGES//,/}
# Install the packages using pacman
sudo pacman -S --needed "$PACKAGES"

#
# Paru for Aur
#
if command -v paru >/dev/null 2>&1; then
  paru --version
else
  sudo pacman -S --needed base-devel
  cd /tmp || exit
  git clone https://aur.archlinux.org/paru.git
  cd paru || exit
  makepkg -si
fi

paru -S --noconfirm --needed \
  dotter

#
# OpenSSH
#
#Create ssh-user group
sudo groupadd ssh-user
sudo usermod -aG ssh-user "$USER"

# Generate fingerprint
sudo rm /etc/ssh/ssh_host_*key*
sudo ssh-keygen -t ed25519 -f /etc/ssh/ssh_host_ed25519_key -N ""
# sudo ssh-keygen -t rsa -b 4096 -f /etc/ssh/ssh_host_rsa_key -N ""

# Remove small Diffe-Hellman moduli
awk '$5 >= 3071' /etc/ssh/moduli | sudo tee /etc/ssh/moduli.safe > /dev/null
sudo mv /etc/ssh/moduli.safe /etc/ssh/moduli
