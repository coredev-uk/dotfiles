#!/bin/sh

WEATHER=`curl -s "wttr.in?format=1"`

echo $WEATHER

