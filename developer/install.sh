#!/bin/bash

PACKAGES_JSON='{{ developer_packages }}'

PACKAGES=${PACKAGES_JSON:1:-1}
PACKAGES=${PACKAGES//,/}
packages_array=($PACKAGES)

# Install the packages using pacman
sudo pacman -S --needed "${packages_array[@]}"


# Rust dev env
sudo pacman -S --noconfirm --needed \
  sccache \
  lld \
  clang


if command -v rustc >/dev/null 2>&1; then
  rustc --version
else
  export CARGO_HOME=~/.config/cargo
  export CARGO_TARGET_DIR=~/.config/cargo/target
  export CARGO_INSTALL_ROOT=~/.config/cargo/install

  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
  rustup component add rust-analyzer
  rustup component add clippy
  rustup component add rustfmt
fi
