#!/usr/bin/env  bash
app=$(adb shell pm list packages | cut -d: -f2 | fzf)
chosen_activity=$(adb shell pm dump "$app" | grep -A 1 'filter' | grep "/" | sed 's/^[[:space:]]*//' | cut -d ' ' -f2 | uniq | fzf)
echo "$chosen_activity"
activity="$chosen_activity"
echo "$activity"
adb shell am start -n "$activity"
# | grep '/' | grep -Po '(?<=/)[^ ]*'
