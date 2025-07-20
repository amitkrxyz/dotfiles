#!/bin/sh

# Usage: yt-playlist-sub.sh <playlist_url>

WHISPER_BASE_DIR="$HOME/myhome/git-repo/whisper.cpp"
MODEL="$WHISPER_BASE_DIR/models/ggml-tiny.en.bin"

playlist_json=$(yt-dlp --dump-single-json --flat-playlist "$1")
playlist_title=$(echo "$playlist_json" | jq -r '.title')
playlist_title_clean=$(
	echo "$playlist_title" | sed 's/[^[:alnum:]]/_/g' | tr -s '_'
)

AUDIO_DIR="${HOME}/Videos/yt-audio/${playlist_title_clean}"
SUB_DIR="${HOME}/Documents/yt-subtitles"
SUB_FILE="${SUB_DIR}/${playlist_title_clean}.md"

mkdir -p "${SUB_DIR}"
mkdir -p "${AUDIO_DIR}/wav"

echo "# [${playlist_title}](${1})" \
	> "$SUB_FILE"

count=1
echo "$playlist_json" | jq -c '.entries[]' | 
	while read -r entry; do
		title=$(echo "$entry" | jq -r '.title')
		title_clean=$(echo "$title" | sed 's/[^[:alnum:]]/_/g' | tr -s '_')
		url=$(echo "$entry" | jq -r '.url')
		m4a_file="${AUDIO_DIR}/${title_clean}.m4a"
		wav_file="${AUDIO_DIR}/wav/${title_clean}.wav"

		echo "$title"
		echo "Downloading audio..."
		yt-dlp \
			-f "bestaudio[ext=m4a]" \
			--extract-audio \
			-o "${m4a_file}" \
			"$url"

		echo "Converting audio..."
		ffmpeg -nostdin -i "${m4a_file}" \
			-ar 16000 -ac 1 -c:a pcm_s16le \
			"${wav_file}"

		echo "Transcribing audio..."
		echo "## [${count}. ${title}](${url})" | tee -a  "$SUB_FILE"

		"${WHISPER_BASE_DIR}/main" \
			--model "${MODEL}" \
			--language en \
			-f "${wav_file}" \
			--translate --no-timestamps \ | tee /dev/tty \
			>> "$SUB_FILE"

		printf "\n\n" >> "$SUB_FILE"
		
		count=$((count+1))
		done
