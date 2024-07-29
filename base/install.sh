#!/bin/bash

LOG_FILE=install.log

echo -e "[O] Install basic packages"
sudo pacman -S -q --needed \
  less \
  bat \
  zsh \
  grml-zsh-config \
  zellij \
  fzf \
  ripgrep \
  ttf-hack-nerd \
  &>> "$LOG_FILE"

echo -e "[O] Create filer and directories"
touch ~/.zshrc &>> "$LOG_FILE"
mkdir ~/.cache/zsh &>> "$LOG_FILE"
mkdir ~/.cache/shell &> "$LOG_FILE"

# Get the name of the shell
shell=/bin/zsh

# Perform actions based on the current shell
if [[ "$shell" != "$SHELL" ]]; then
  echo -e "[O] Set shell to $shell"
  chsh -s /bin/zsh
  sudo chsh -s /bin/zsh
fi
