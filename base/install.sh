#!/bin/bash

# Install the packages using pacman
sudo pacman -S --needed \
  bat \
  zsh \
  grml-zsh-config \
  zellij \
  fzf \
  ripgrep \
  ttf-hack-nerd

touch ~/.zshrc
mkdir ~/.cache/shell

# Get the name of the shell
shell=/bin/zsh

# Perform actions based on the current shell
if [[ "$shell" != "$SHELL" ]]; then
  chsh -s /bin/zsh
  sudo chsh -s /bin/zsh
fi
