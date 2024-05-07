#!/bin/bash
output=$(playerctl metadata --player=cider,spotify --format '{{artist}} [ {{title}} ]' 2>&1)
player=$(playerctl metadata --format '{{playerName}}' 2>&1)

if [[ "$output" != "No players found" && "$output" != "No player could handle this command" && "$(playerctl status 2>&1)" == "Playing" ]]; then

	if [[ $1 == "--waybar" ]]; then
		echo '{"text": "\ud83c\udfb6 '$output'", "class": "custom-nowplaying", "alt": "'$player'"}'
	else
		echo $output
	fi
else
	echo ""
fi
