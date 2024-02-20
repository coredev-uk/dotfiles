#!/bin/bash

if $(pgrep -x polybar > /dev/null); then
  killall -q polybar
fi

if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar --reload main &
  done
else
  polybar --reload main &
fi
