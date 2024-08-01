#!/bin/bash

echo -e "[O] Install developer packages"
sudo pacman -S --needed --noconfirm \
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
echo -e "[O] Set up Rust development environment"
sudo pacman -S --needed --noconfirm \
  sccache \
  lld \
  clang


if command -v rustc >/dev/null 2>&1; then
  rustc --version
else
  echo -e "[O] Install Rust"
  export {{ rust.cargo_home }}
  export {{ rust.cargo_target_dir }}
  export {{ rust.cargo_install_root }}

  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --no-modify-path -y -q
  rustup component add rust-analyzer
  rustup component add clippy
  rustup component add rustfmt
fi

echo -e "[O] Install Rust tools"
cargo install cargo-audit
cargo install cargo-deny
cargo install cargo-udeps
cargo install cargo-tarpaulin
cargo install cargo-watch

echo -e "[O] Install Dotter"
cargo install dotter

#
# Paru for Aur
#
echo -e "[O] Install Paru for AUR"
PATH=$PATH:~/.config/cargo/bin
if command -v paru >/dev/null 2>&1; then
  paru --version
else
  sudo pacman -S --needed --noconfirm base-devel

  cd /tmp || exit
  git clone https://aur.archlinux.org/paru.git

  cd paru || exit

  makepkg -sid
  rm -rf /tmp/paru
  sudo pacman -R --noconfirm paru-debug
fi
