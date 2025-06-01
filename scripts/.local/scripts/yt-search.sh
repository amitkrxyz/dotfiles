#!/usr/bin/env sh

# Search youtube video and get the url
# Dependency: curl, jq, parallel, kitty

# For instance url: https://api.invidious.io/
URL="https://invidious.f5.si"

echo "Searching for videos..." >&2
# replaceing spaces with %20
query=$(echo "$*" | sed 's/ /%20/g')

res=$(curl -s "$URL/api/v1/search?type=video&q=$query")

urls=$(echo "$res" |
	jq .[].videoThumbnails | jq 'map(select(.quality == "sddefault"))' | jq -r .[].url)

echo "$urls" | 
	parallel  -j 20 --line-buffer \
    'filename=$(echo {} | cut -d/ -f5); wget --no-clobber --quiet {} -O "/tmp/yt/thumbnails/$filename.jpg"' 

# fzf behaves weirdly with fish shell
SHELL="/bin/sh"

chose=$(echo "$res" | jq .[] | jq "[.title, .author, .videoId]" | jq -r 'join("\t")' | 
		fzf --preview-window 'up:50%' \
			--preview 'kitten icat --clear --transfer-mode=memory --stdin=no --place=${FZF_PREVIEW_COLUMNS}x${FZF_PREVIEW_LINES}@20x1  /tmp/yt/thumbnails/$(echo {} | cut -f 3).jpg')


if [ -z "$chose" ]; then
	echo "Nothing Selected, exiting..." >&2
	exit 1
fi
title=$(echo "$chose" | cut -f 1)
author=$(echo "$chose" | cut -f 2)

echo "Title: $title" >&2
echo "Channel: $author" >&2

vid_url="https://youtu.be/$(echo "$chose" | cut -f3)"

echo "$vid_url"

