#!/bin/bash

# Install the packages using pacman
sudo pacman -S --needed \
  tig \
  git \
  neovim \
  powerline-fonts \
  unzip \
  npm \
  python \
  tree-sitter-cli

###############################################################################
# Rust development environment
###############################################################################
sudo pacman -S --needed \
  sccache \
  lld \
  clang


if command -v rustc >/dev/null 2>&1; then
  rustc --version
else
  export {{ rust.cargo_home }}
  export {{ rust.cargo_target_dir }}
  export {{ rust.cargo_install_root }}

  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
  rustup component add rust-analyzer
  rustup component add clippy
  rustup component add rustfmt
fi
