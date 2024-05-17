#!/bin/bash
artist=$(playerctl metadata --player=cider,spotify --format '{{markup_escape(artist)}}' 2>&1)
title=$(playerctl metadata --player=cider,spotify --format '{{markup_escape(title)}}' 2>&1)
album=$(playerctl metadata --player=cider,spotify --format '{{markup_escape(album)}}' 2>&1)
player=$(playerctl metadata --format '{{playerName}}' 2>&1)

if [[ "$artist" != "No players found" && "$artist" != "No player could handle this command" && "$(playerctl status 2>&1)" == "Playing" ]]; then

	if [[ $1 == "--waybar" ]]; then
		echo '{"text": "'$artist' [ <span color=\"#fff\">'$title'</span> ]", "class": "custom-nowplaying", "alt": "'$player'", "tooltip": "'$album'"}'
	else
		echo "$artist [ $title ]"
	fi
else
	echo ""
fi
