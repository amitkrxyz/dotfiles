#!/usr/bin/env sh
if [ $(wlr-randr --json | jq ".[] | select(.name=\"eDP-1\").enabled") = "true" ]; then 
	niri msg output eDP-1 off
else 
	niri msg output eDP-1 on
fi
