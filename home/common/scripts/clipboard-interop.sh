#!/bin/bash

#src: https://gist.github.com/andriandreo/cc48e2d67c389919e18c54429d768c1f#file-clipboard-sh

while true; do
	# Capture the current clipboard content
	clipboard_content=$(wl-paste)

	# Remove trailing newlines using sed
	cleaned_content=$(echo "$clipboard_content" | sed ':a; /^$/{$d; N;}; /\n$/ba')

	# Place the cleaned content back into the clipboard
	echo -n "$cleaned_content" | xclip -selection clipboard

	# Use xclip to set the clipboard content to itself (optional redundancy)
	xclip -selection clipboard -o | wl-copy

	# Wait for 0.5 seconds before the next iteration
	sleep 0.5
done