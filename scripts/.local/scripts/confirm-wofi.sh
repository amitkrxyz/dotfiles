#!/usr/bin/env sh
# Run command if user confirms selection
#
# Usage:
#   confirm-wofi.sh "Command to run"

if ! command -v wofi &> /dev/null; then
    echo "Please install wofi"
    exit 1
fi

selection=$(printf "yes\nno" | wofi --dmenu --prompt="Run: $1")

if [ "$selection" = "yes" ]; then
    eval "$1"
fi
