#!/bin/sh

directory=~/pictures/wallpaper

if [ ! -d "$directory" ]; then
    echo "Directory does not exist."
    exit
fi

random_background=$(ls $directory/* | shuf -n 1)

if [ "$XDG_SESSION_TYPE" = "x11" ]; then
    DISPLAY=:0.0 feh --bg-fill $random_background
elif [ "$XDG_SESSION_TYPE" = "wayland" ]; then
    monitors=$(hyprctl monitors | grep Monitor | awk '{print $2}')

    if ! $(pgrep -x hyprpaper &>2); then
        hyprpaper
    fi

    hyprctl hyprpaper unload all
    hyprctl hyprpaper preload $random_background
    for monitor in $monitors; do
        hyprctl hyprpaper wallpaper "$monitor, $random_background"
    done
else
    echo "Unsupported Environment"
    exit
fi