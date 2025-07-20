#!/bin/sh

BASE_DIR="$HOME/myhome/git-repo/whisper.cpp"
MODEL="$BASE_DIR/models/ggml-tiny.en.bin"

DOWNLOAD_DIR="$BASE_DIR/samples/yt-sub"
tmp_file="${DOWNLOAD_DIR}/yt-dlp-tempfile"

check_requirements() {
    if ! command -v ffmpeg > /dev/null
    then
        echo "ffmpeg is required: https://ffmpeg.org/"
        exit 1
    fi
	if ! command -v yt-dlp > /dev/null
    then
        echo "yt-dlp is required: https://github.com/yt-dlp/yt-dlp"
        exit 1
    fi
	if [ ! -d "$BASE_DIR" ]; then
		echo "whisper.cpp not found. Please clone the repository. https://github.com/ggerganov/whisper.cpp"
		exit 1
	fi
}

print_usage() {
    echo "Usage: $0 <video-url>"
    echo "Example: $0 https://www.youtube.com/watch?v=dQw4w9WgXcQ"
}

check_requirements

if [ -z "$1" ]; then
    print_usage
    exit 1
fi

echo "Downloading audio..."
yt-dlp \
	-f "bestaudio[ext=m4a]" \
	--extract-audio \
	--print-to-file "%(filename)s" "${tmp_file}" \
	-o "$DOWNLOAD_DIR/%(title)s.%(ext)s" \
	"$1"

title_name=$(basename "$(cat "$tmp_file")" .m4a)

echo "Converting audio to wav..."

ffmpeg -i "${DOWNLOAD_DIR}/${title_name}".m4a \
	-ar 16000 -ac 1 -c:a pcm_s16le \
	"${DOWNLOAD_DIR}/${title_name}".wav


echo "Transcribing audio..."

"${BASE_DIR}/main" \
	--print-colors \
	--model "${MODEL}" \
	--language en \
	-f "${DOWNLOAD_DIR}/${title_name}".wav \
	-otxt \
	--translate

# -osrt \
# -ovtt -olrc \

rm *.wav *.m4a
rm "${tmp_file}"
