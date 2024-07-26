#!/bin/bash

PACKAGES_JSON='{{ developer_packages }}'
# Remove the brackets
PACKAGES=${PACKAGES_JSON:1:-1}
# Remove the quotes and commas
PACKAGES=${PACKAGES//\"/}
PACKAGES=${PACKAGES//,/}
# Install the packages using pacman
sudo pacman -S --needed "$PACKAGES"


# Rust dev env
sudo pacman -S --noconfirm --needed \
  sccache \
  lld \
  clang

if command -v rustc >/dev/null 2>&1; then
  rustc --version
else
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
  rustup component add rust-analyzer
  rustup component add clippy
  rustup component add rustfmt
fi
