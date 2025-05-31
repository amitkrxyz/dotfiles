#!/usr/bin/env bash

tmp=$(mktemp)
fzf --multi > "$tmp"

readarray -t files < "$tmp"

echo "Uploading files"
echo "${files[@]}"

if [[ ${#files[@]} -eq 0 ]]; then
	echo "No files selected"
	exit
elif [[ ${#files[@]} -eq 1 ]]; then
	file="${files[0]}"
else
	file=$(mktemp --dry-run -t XXXX.zip)
	echo "Creating zip"
	zip -r "$file" "${files[@]}"
	echo "$file"
fi

curl -F "file=@$file"  https://0x0.st | tee
