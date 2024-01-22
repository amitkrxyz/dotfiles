#!/usr/bin/env sh

error() {
	echo "No channel selected"
	exit 1
}
chose=$(jq .[] <~/.local/share/my/iptv/streams.json | jq "[.channel, .url]" | jq -r 'join("\t")' | grep -v '^[[:blank:]]' | fzf)

[ "$chose" ] || error
name=$(echo "$chose" | cut -f1)
link=$(echo "$chose" | cut -f2)
echo "$name"
echo "$link"
mpv "$link"
