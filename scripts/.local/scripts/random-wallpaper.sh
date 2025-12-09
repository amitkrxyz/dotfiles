#!/usr/bin/env sh

rnd_wall=$(find ~/Pictures/wallpaper -type f | shuf | head -1)

echo $rnd_wall
swaybg -o '*' -i "$rnd_wall"
