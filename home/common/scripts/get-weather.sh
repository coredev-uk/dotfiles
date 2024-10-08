#!/usr/bin/env bash

BAR_TYPE=$1

weather=$(curl -s "https://wttr.in?format=1")
if [[ "$weather" == *"Unknown"* ]] || [[ "$weather" == *"Error"* ]]; then
	exit
fi

text=$(echo "$weather" | sed -E "s/\s+/ /g")
tooltip="hey"

if [ "$BAR_TYPE" == "polybar" ]; then
	echo $text
elif [ "$BAR_TYPE" == "waybar" ]; then
	echo "{\"text\":\"$text\", \"tooltip\":\"$tooltip\"}"
else
	echo "Unsupported Bar"
fi