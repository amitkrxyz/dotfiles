#!/bin/sh

# Dependency: wofi
# Usage: Run the script

prompt=$(echo -e "start\nstop" | wofi --dmenu --height 200 -p "Start/Stop Buckspring")


if [  "$prompt" == "start" ]; then
	killall buckle
	cd ~/myhome/git-repo/bucklespring/
	./buckle -f  -g 25

elif [  "$prompt" == "stop" ]; then
	killall buckle
fi
