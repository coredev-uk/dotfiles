#!/usr/bin/env bash


i3_workspaces() {
  all_workspaces=$(i3-msg -t get_workspaces | jq -c '.[]')
  selected_workspace=$(i3-msg -t get_workspaces | jq --unbuffered -rc '.[] | select(.focused == true)')

  buf=""

  for d in $all_workspaces; do
    name=""
    class="workspace"

    if [[ $d == *"${selected_workspace}"* ]]; then
      name=""
      class="selected"
    fi

    buf="$buf (box :class \"$class\" \"$name\")"
  done

  echo "(box :class \"workspaces\" :halign \"center\" :valign \"center\" :vexpand true :hexpand true :spacing 10 $buf)"
}


workspaces() {
  i3_workspaces
  i3-msg -t subscribe -m '{"type":"workspace"}' |
  while read -r _; do
    i3_workspaces
  done
}

workspaces

