#!/usr/bin/env sh

WHISPER_BIN="$HOME/myhome/git-repo/whisper.cpp/main"
WHISPER_MODEL="$HOME/myhome/git-repo/whisper.cpp/models/ggml-tiny.en.bin"

print_usage() {
	echo "Usage: $0 <wav-file>"
}

if [ -z "$1" ]; then
	print_usage
	exit 1
fi

"$WHISPER_BIN" --print-colors  --no-prints  --split-on-word --model "$WHISPER_MODEL" --language en -f "$1"
