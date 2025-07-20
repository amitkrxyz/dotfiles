#!/usr/bin/env sh
PIPER_BIN="$HOME/Applications/piper/piper"
MODEL="$HOME/Applications/piper/en_GB-alba-medium.onnx"

# Get output from pipe and argument in one variable

input="$1"
if [ -z "$input" ]; then
	input="$(cat)"
else
	piped_input="$(cat)"
	input="$(printf "%s\n%s" "$input" "$piped_input")"
fi

echo "$input" | "$PIPER_BIN" -m "$MODEL" --output-raw | \
	aplay -r 22050 -f S16_LE -t raw -
