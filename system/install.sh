#!/bin/bash

LOG_FILE=install.log

echo -e "[O] Install OpenSSH"
sudo pacman -S -q --needed \
  openssh \
  &>> "$LOG_FILE"

echo -e "[O] Create ssh-user group"
sudo groupadd ssh-user
sudo usermod -aG \
  ssh-user \
  "$USER" \
  &>> "$LOG_FILE"

echo -e "[O] Generate fingerprint"
sudo rm /etc/ssh/ssh_host_*key* &>> "$LOG_FILE"
sudo ssh-keygen -t ed25519 -f /etc/ssh/ssh_host_ed25519_key -N "" &>> "$LOG_FILE"
# sudo ssh-keygen -t rsa -b 4096 -f /etc/ssh/ssh_host_rsa_key -N "" &>> "$LOG_FILE"

echo -e "[O] Remove small Diffe-Hellman moduli"
awk '$5 >= 3071' /etc/ssh/moduli | sudo tee /etc/ssh/moduli.safe > /dev/null &>> "$LOG_FILE"
sudo mv /etc/ssh/moduli.safe /etc/ssh/moduli &>> "$LOG_FILE"
