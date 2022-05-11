#!/usr/bin/env bash

# Add this script to your wm startup file.

DIR="$HOME/.config/polybar"

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch the bar
# polybar -q main -c "$DIR"/config.ini &

# Multiple Displays
if type "xrandr"; then
	for m in $(xrandr --query | grep " connected" | grep "primary" | cut -d" " -f1); do
		MONITOR=$m TRAY_POS=right polybar --reload -q main -c "$DIR"/config.ini &
	done
	for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
		if [[ $m != $(xrandr --query | grep " connected" | grep "primary" | cut -d" " -f1) ]]; then 
			MONITOR=$m TRAY_POS=none polybar --reload -q main -c "$DIR"/config.ini &
		fi
	done
else
	polybar --reload -q main -c "$DIR"/config.ini &
fi
