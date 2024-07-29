#!/bin/bash

echo -e "[O] Install OpenSSH"
sudo pacman -S -q --needed --noconfirm \
  openssh

echo -e "[O] Create ssh-user group"
sudo groupadd ssh-user
sudo usermod -aG \
  ssh-user \
  "$USER"

echo -e "[O] Generate fingerprint"
sudo rm /etc/ssh/ssh_host_*key*
sudo ssh-keygen -t ed25519 -f /etc/ssh/ssh_host_ed25519_key -N ""
# sudo ssh-keygen -t rsa -b 4096 -f /etc/ssh/ssh_host_rsa_key -N ""

echo -e "[O] Remove small Diffe-Hellman moduli"
awk '$5 >= 3071' /etc/ssh/moduli | sudo tee /etc/ssh/moduli.safe > /dev/null
sudo mv /etc/ssh/moduli.safe /etc/ssh/moduli
