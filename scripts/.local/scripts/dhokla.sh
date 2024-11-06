#!/usr/bin/env sh

URL="https://na1.dhokla.net"
DIRTOSAVE="$HOME/Videos/dhokla"

play_video() {
	filename=$1
	url=$2

	if [ ! -d "$DIRTOSAVE" ]; then
		mkdir -p "$DIRTOSAVE"
	fi
	echo "Saving file to $DIRTOSAVE/$filename"
	killall wget
	wget -qbc -O "$DIRTOSAVE/$filename" "$url"
	echo "wget -c -O $DIRTOSAVE/$filename $url"
	sleep 5
	mpv "$DIRTOSAVE/$filename"
}
prompt_yes_or_no() {
	while true; do
		printf "Do you want to continue? (yes/no): " && read -r choice
		case "$choice" in
		[Yy] | [Yy][Ee][Ss])
			return 0 # Return success (yes)
			;;
		[Nn] | [Nn][Oo])
			return 1 # Return failure (no)
			;;
		*)
			echo "Please enter 'yes' or 'no'."
			;;
		esac
	done
}

fetch_directory() {
	s=$1

	is_dir=$(echo "$s" | cut -f 3)
	id=$(echo "$s" | cut -f 2)

	if [ "$is_dir" != "true" ]; then
		name=$(echo "$s" | cut -f 1)
		size=$(echo "$s" | cut -f 4)
		vid_url="$URL/f/$id"

		echo "URL: $vid_url"
		echo "Video id: $id"
		echo "Filename: $name"
		echo "File size: $(echo "$size" | numfmt --to=iec)B"
		if prompt_yes_or_no; then
			play_video "$name" "$vid_url"
		else
			echo "Cancelled..."
		fi
	else
		next_result=$(curl -s "$URL/api/d/$id" | jq .data.files[] | jq "[.name, .id, .dir, .size]" | jq -r 'join("\t")' | fzf)
		if [ -z "$next_result" ]; then
			echo "Nothing Selected, exiting..."
			exit 0
		fi
		fetch_directory "$next_result"
	fi
}

error() {
	bin_file=$(echo "$0" | rev | cut -d/ -f1 | rev)
	echo "Usage: $bin_file <query>"
	echo "Example: $bin_file 'Mr. Robot'"
	exit 1
}

# trap 'echo "Ctrl+C pressed. exiting..." && exit 0' INT
query=$1

[ "$query" ] || printf "Query: " && read -r query
[ "$query" ] || error

query=$(echo "$query" | sed 's/ /%20/g')
result=$(curl -s "$URL/api/s/$query" | jq .data[] | jq "[.name, .id, .dir]" | jq -r 'join("\t")')

if [ -z "$result" ]; then
	echo "Nothing found"
	exit 0
fi

selected=$(echo "$result" | fzf)

if [ -z "$selected" ]; then
	echo "Nothing Selected"
	exit 0
fi

fetch_directory "$selected"
