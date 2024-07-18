#!/bin/bash
package_list='{{ packages }}'

# Remove the brackets and quotes
packages=$(echo "$package_list" | tr -d '[]"')

# Convert the comma-separated string to an array
IFS=',' read -r -a package_array <<< "$packages"

for package in "${package_array[@]}"; do
  pacman -S --noconfirm --needed "$package"
done
