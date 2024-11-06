#!/usr/bin/env  sh

# Launch an android activity interactively with fzf
#
# Dependency: adb(android-tools), fzf
# Usage: Connect the android device with adb, then run the script
#

app=$(adb shell pm list packages | cut -d: -f2 | fzf)
chosen_activity=$(adb shell pm dump "$app" | grep -A 1 'filter' | grep "/" | sed 's/^[[:space:]]*//' | cut -d ' ' -f2 | uniq | fzf)
echo "$chosen_activity"
activity="$chosen_activity"
echo "$activity"
adb shell am start -n "$activity"
