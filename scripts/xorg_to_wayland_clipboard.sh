#!/bin/bash

on_clipboard_change() {
	NEW_CONTENT=$(xclip -selection clipboard -o)
	echo "$NEW_CONTENT" | wl-copy
}

while true; do
	clipnotify
	on_clipboard_change
done
