#!/usr/bin/env sh

# Play iptv from the terminal using mpv
# Dependency: mpv, jq
#
# Usage:
# Download the streams.json from
# https://github.com/iptv-org/api
# and change the STREAM_JSON_FILE variable accordingly
# and run the script

error() {
	echo "No channel selected"
	exit 1
}

STREAM_JSON_FILE="$HOME/.local/share/my/iptv/streams.json"

chose=$(jq .[] <"$STREAM_JSON_FILE" | jq "[.channel, .url]" | jq -r 'join("\t")' | grep -v '^[[:blank:]]' | fzf)

[ "$chose" ] || error
name=$(echo "$chose" | cut -f1)
link=$(echo "$chose" | cut -f2)
echo "$name"
echo "$link"
mpv --no-resume-playback "$link" 
