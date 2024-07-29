#!/bin/bash

LOG_FILE=install.log

echo -e "[O] Install developer packages"
sudo pacman -S --needed \
  tig \
  git \
  neovim \
  powerline-fonts \
  unzip \
  npm \
  python \
  tree-sitter-cli \
  &>> "$LOG_FILE"

###############################################################################
# Rust development environment
###############################################################################
echo -e "[O] Set up Rust development environment"
sudo pacman -S --needed \
  sccache \
  lld \
  clang \
  &>> "$LOG_FILE"


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

echo -e "[O] Install Dotter"
cargo install dotter &>> "$LOG_FILE"

#
# Paru for Aur
#
echo -e "[O] Install Paru for AUR"
PATH=$PATH:~/.config/cargo/bin
if command -v paru >/dev/null 2>&1; then
  paru --version
else
  sudo pacman -S --needed base-devel &>> "$LOG_FILE"

  cd /tmp || exit
  git clone https://aur.archlinux.org/paru.git &>> "$LOG_FILE"

  cd paru || exit

  makepkg -sid &>> "$LOG_FILE"
  rm -rf /tmp/paru &>> "$LOG_FILE"
  sudo pacman -R --noconfirm paru-debug &>> "$LOG_FILE"
fi
