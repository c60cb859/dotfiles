#!/bin/bash

scripts_dir="./.setup"
chmod +x "$scripts_dir"/*

for script in "$scripts_dir"/*; do
    sudo "$script"
done
