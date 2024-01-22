#!/usr/bin/env sh
adbi shell dumpsys activity top | grep "ACTIVITY" | awk '{ print $2 }' | cut -d/ -f1 | tac
