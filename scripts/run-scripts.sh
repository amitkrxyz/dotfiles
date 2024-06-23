#!/usr/bin/env sh

script_name=$(basename "$0")

dir="$HOME/.local/scripts/"

script_to_run=$(find $dir -type f ! -name "$script_name" -exec basename {} \; | wofi --dmenu)

sh "$dir$script_to_run"
