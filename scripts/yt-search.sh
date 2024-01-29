#!/usr/bin/env sh

# Search youtube video and get the url
# Dependency: curl, jq

# For instance url: https://api.invidious.io/
URL="https://invidious.einfachzocken.eu"

# replaceing spaces with %20
query=$(echo "$*" | sed 's/ /%20/g')

chose=$(curl -s "$URL/api/v1/search?type=video&q=$query" | jq .[] | jq "[.title, .author, .videoId]" | jq -r 'join("\t")' | fzf)

title_author=$(echo "$chose" | cut -f 1,2)

vid_url=$(echo "$chose" | cut -f3)

printf "%s\thttps://youtu.be/%s\n" "$title_author" "$vid_url"
