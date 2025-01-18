#!/usr/bin/env sh

# Get the top Activity from adb
# alias adbi='adb -s $(adb devices | grep \'device$\' | cut -f1 | fzf -1)'

adb shell dumpsys activity top | grep "ACTIVITY" | awk '{ print $2 }' | cut -d/ -f1 | tac
