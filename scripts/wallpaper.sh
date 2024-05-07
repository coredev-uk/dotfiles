#!/bin/bash

directory=~/.wallpapers
monitors=$(hyprctl monitors | grep Monitor | awk '{print $2}')
if [ -d "$directory" ]; then
	random_background=$(ls $directory/* | shuf -n 1)

	hyprctl hyprpaper unload all
	hyprctl hyprpaper preload $random_background

	for monitor in $monitors; do
		hyprctl hyprpaper wallpaper "$monitor, $random_background"
	done
fi
