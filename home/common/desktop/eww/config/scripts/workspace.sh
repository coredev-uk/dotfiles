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

hypr_workspaces() {
  all_workspaces=$(hyprctl workspaces -j | jq -c '.[].id')
  selected_workspace=$(hyprctl activeworkspace -j | jq --unbuffered -rc '.id')

  buf=""

  for d in $all_workspaces; do
    name=""
    class="workspace"

    if [[ $d == "${selected_workspace}" ]]; then
      name=""
      class="selected"
    fi

    buf="$buf (box :class \"$class\" \"$name\")"
  done

  stdbuf -o0 echo "(box :class \"workspaces\" :halign \"center\" :valign \"center\" :vexpand true :hexpand true :spacing 10 $buf)"
}

workspaces() {
  if [[ $(pgrep i3) ]]; then
    i3_workspaces
    i3-msg -t subscribe -m '{"type":"workspace"}' |
    while read -r _; do
      i3_workspaces
    done
  elif [[ $(pgrep hypr) ]]; then
    hypr_workspaces
    socat "UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" - | while read -r event; do
    hypr_workspaces
    done
  fi
}

workspaces

