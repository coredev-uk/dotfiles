#!/usr/bin/env bash

MUSIC_DIR="$HOME/.music/"
mkdir -p "$HOME/.music/"

PLAYER="cider,spotify"

art() {
  meta=$(playerctl metadata --player=${PLAYER})
  url=$(echo "${meta}" | grep artUrl | awk '{print $3}')
  id=$(echo "${meta}" | grep trackid | awk -F'/' '{print $NF}' | sed "s/'//")
  file_path="${MUSIC_DIR}${id}.jpg"

  if [ ! -e file_path ]; then
    ffmpeg -i "$url" -vf "scale=24:24" "$file_path"
  fi

  echo "$file_path"
}

title() {
  echo $(playerctl metadata --player=${PLAYER} --format '{{title}}')
}

artist() {
  echo $(playerctl metadata --player=${PLAYER} --format '{{artist}}')
}

case "$1" in
  --art)
    art
    ;;
  --title)
    title
    ;;
  --artist)
    artist
    ;;
esac
