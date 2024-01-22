#!/bin/env bash
if ping -c 1 google.com &>/dev/null; then
	# Network is available, execute your command here
	curr_date=$(date -I)
	ip_addr=$(curl -s ifconfig.me)

	echo $curr_date $ip_addr >>~/.local/share/my/iplog.txt
else
	# Network is not available
	echo "Network not available. Skipping the command." >&2
	cat ~/.local/share/my/iplog.txt | uniq >/tmp/tmpfile && mv /tmp/tmpfile ~/.local/share/my/iplog.txt
fi
