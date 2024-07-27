#!/bin/bash

# Install the packages using pacman
sudo pacman -S --needed \
  openssh

#
# OpenSSH
#
#Create ssh-user group
GROUPS=("ssh-user")

for GROUP in "${GROUPS[@]}"; do
    # Check if the user is already in the group
    if id -nG "$USER" | grep -qw "$GROUP"; then
        echo "$USER is already a member of $GROUP"
    else
        # Add the user to the group
        sudo groupadd ssh-user
        sudo usermod -aG "$GROUP" "$USER"
        echo "Added $USER to $GROUP"
    fi
done

# Generate fingerprint
sudo rm /etc/ssh/ssh_host_*key*
sudo ssh-keygen -t ed25519 -f /etc/ssh/ssh_host_ed25519_key -N ""
# sudo ssh-keygen -t rsa -b 4096 -f /etc/ssh/ssh_host_rsa_key -N ""

# Remove small Diffe-Hellman moduli
awk '$5 >= 3071' /etc/ssh/moduli | sudo tee /etc/ssh/moduli.safe > /dev/null
sudo mv /etc/ssh/moduli.safe /etc/ssh/moduli
