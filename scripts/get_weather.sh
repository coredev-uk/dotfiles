#!/usr/bin/env bash

if [ "$1" != "--polybar" ] && [ "$1" != "--waybar" ]; then
	LOCATION=$1
else
	BAR_TYPE=$1
	LOCATION=$2
fi

weather=$(curl -s "https://wttr.in/$2?format=1")
if [[ "$weather" == *"Unknown"* ]] || [[ "$weather" == *"Error"* ]]; then
	exit
fi

text=$(echo "$weather" | sed -E "s/\s+/ /g")
tooltip="hey"

if [ "$BAR_TYPE" == "--polybar" ]; then
	echo $text
elif [ "$BAR_TYPE" == "--waybar" ]; then
	echo "{\"text\":\"$text\", \"tooltip\":\"$tooltip\"}"
else
	echo "Unsupported Bar"
fi
