#!/usr/bin/env sh

# Dependencies:
# aandrew-me/tgpt
#   - AI Chat in terminal without needing API keys
#   - https://github.com/aandrew-me/tgpt
#
# rhasspy/piper
#   - A fast, local neural text to speech system
#   - https://github.com/rhasspy/piper

# piper path with the binary and model file
PIPER_FOLDER="$HOME/.local/mybin/piper/"
MODEL='en_GB-alba-medium.onnx'

tgpt -q "$*" | tee /tmp/ans.txt

# printing some blank lines why not
printf "\n\n"

"$PIPER_FOLDER/piper" -m "$PIPER_FOLDER/$MODEL" --output-raw </tmp/ans.txt |
	aplay -r 22050 -f S16_LE -t raw -
