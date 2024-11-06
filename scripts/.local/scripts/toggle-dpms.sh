#!/usr/bin/env sh
if [ $(hyprctl monitors -j | jq ".[]|select(.name==\"eDP-1\").dpmsStatus") = "true" ]; then 
	hyprctl dispatch dpms off eDP-1; 
else 
	hyprctl dispatch dpms on eDP-1;
fi
