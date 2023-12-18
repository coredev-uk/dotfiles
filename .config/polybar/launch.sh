#!/bin/bash

if $(pgrep -x polybar > /dev/null); then
  killall -q polybar
fi

for m in $(polybar --list-monitors | cut -d ":" -f1); do
    t=false
    if [ "$m" = $(polybar --list-monitors | grep 'primary' | cut -d ":" -f1) ]; then
      t=true
    fi
    MONITOR=$m TRAY=$t polybar --reload main > ~/.xsession.log 2>&1 &
done
