#!/bin/bash
output=$(playerctl metadata --player=cider,spotify --format '{{markup_escape(artist)}} [ {{markup_escape(title)}} ]' 2>&1)
album=$(playerctl metadata --player=cider,spotify --format '{{markup_escape(album)}}' 2>&1)
player=$(playerctl metadata --format '{{playerName}}' 2>&1)

if [[ "$output" != "No players found" && "$output" != "No player could handle this command" && "$(playerctl status 2>&1)" == "Playing" ]]; then

	if [[ $1 == "--waybar" ]]; then
		echo '{"text": "'$output'", "class": "custom-nowplaying", "alt": "'$player'", "tooltip": "'$album'"}'
	else
		echo $output
	fi
else
	echo ""
fi
