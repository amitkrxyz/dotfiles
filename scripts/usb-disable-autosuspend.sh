#!/usr/bin/env sh

for dev in /sys/bus/usb/devices/*/power/control; do
        echo $dev
        # echo on > $dev
done
