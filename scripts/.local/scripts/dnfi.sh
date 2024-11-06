#!/bin/env sh

if [[ "$1" ]] && q="$1" || read -p "Enter Search Query: " q
[[ "$q" ]] || exit

pkg=$(dnf search -C "$q" | fzf --prompt "Select Packages: " -m | cut -d: -f1 | cut -d. -f1 | tr "\n" " ")

[[ "$pkg" ]] || exit

echo "Installing these packages: $pkg"

sudo dnf install "$pkg"
