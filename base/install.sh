#!/bin/bash

echo -e "[O] Install basic packages"
sudo pacman -S -q --needed --noconfirm \
  less \
  bat \
  zsh \
  zellij \
  fzf \
  ripgrep \
  ttf-hack-nerd

echo -e "[O] Create filer and directories"
touch ~/.zshrc
mkdir ~/.cache/zsh
mkdir ~/.cache/shell

# Get the name of the shell
shell=/bin/zsh

# Perform actions based on the current shell
if [[ "$shell" != "$SHELL" ]]; then
  echo -e "[O] Set shell to $shell"
  chsh -s "$shell"
  sudo chsh -s "$shell"
fi
