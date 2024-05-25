#!/bin/bash
escaped_artist=$(playerctl metadata --player=cider,spotify --format '{{markup_escape(artist)}}' 2>&1)
escaped_title=$(playerctl metadata --player=cider,spotify --format '{{markup_escape(title)}}' 2>&1)
escaped_album=$(playerctl metadata --player=cider,spotify --format '{{markup_escape(album)}}' 2>&1)

artist=$(playerctl metadata --player=cider,spotify --format '{{artist}}' 2>&1)
title=$(playerctl metadata --player=cider,spotify --format '{{title}}' 2>&1)
album=$(playerctl metadata --player=cider,spotify --format '{{album}}' 2>&1)

player=$(playerctl metadata --format '{{playerName}}' 2>&1)

if [[ "$artist" != "No players found" && "$artist" != "No player could handle this command" && "$(playerctl status 2>&1)" == "Playing" ]]; then

	if [[ $1 == "--waybar" ]]; then
		echo '{"text": "'$escaped_artist' [ <span color=\"#fff\">'$escaped_title'</span> ]", "class": "custom-nowplaying", "alt": "'$player'", "tooltip": "'$escaped_album'"}'
	elif [[ $1 == "--polybar" ]]; then
		echo "$artist %{F#fff}[ $title ]%{F-}"
	fi
else
	echo ""
fi
