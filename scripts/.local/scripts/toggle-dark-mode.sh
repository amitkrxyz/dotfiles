#!/usr/bin/env sh

gtk3_light_theme="adw-gtk3"
gtk3_dark_theme="adw-gtk3-dark"

current_mode=$(gsettings get org.gnome.desktop.interface color-scheme)

echo $current_mode

echo "Toggling dark mode"
if [ "$current_mode" == "'prefer-dark'" ]; then
        echo "Current mode is dark"
        # GTK4
        gsettings set org.gnome.desktop.interface color-scheme "prefer-light"
        # GTK3
        gsettings set org.gnome.desktop.interface gtk-theme "$gtk3_light_theme"
        echo "Light mode set"
        notify-send "Light mode set"
else
        echo "Current mode is light"
        # GTK4
        gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"
        # GTK3
        gsettings set org.gnome.desktop.interface gtk-theme "$gtk3_dark_theme"
        echo "Dark mode set"
        notify-send "Dark mode set"
fi
