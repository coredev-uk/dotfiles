#!/usr/bin/env bash

CURRENT_MONITOR_ID="$1"

i3_workspaces() {
  workspaces=$(i3-msg -t get_workspaces | jq -c '.[]')
  selected_workspace=$(echo "$all_workspaces" | jq -r 'select(.focused == true).num')

  buf=""
  for k in $workspaces; do
    workspace_num=$(echo "$k" | jq -r '.num')
    class="workspace"
    name=""

    if [[ "$workspace_num" == "$selected_workspace" ]]; then
      class="selected"
      name=""
    fi

    buf="$buf (box :class \"$class\" \"$name\")"
  done

  echo "(box :class \"workspaces\" :halign \"center\" :valign \"center\" :vexpand true :hexpand true :spacing 10 $buf)"
}

hypr_workspaces() {
  workspaces=$(hyprctl workspaces -j | jq '.[] | del(select(.id == -99)) | .id')
  #selected_workspace=$(hyprctl monitors -j | jq --argjson arg "$CURRENT_MONITOR_ID" '.[] | select(.id == $arg).activeWorkspace.id')
  selected_workspace=$(hyprctl activeworkspace -j | jq -r '.id')

  buf=""
  for k in $workspaces; do
    workspace_num=$k
    class="workspace"
    name=""

    if [[ "$workspace_num" == "$selected_workspace" ]]; then
      class="selected"
      name=""
    fi

    buf="$buf (box :class \"$class\" \"$name\")"
  done

  echo "(box :class \"workspaces\" :halign \"center\" :valign \"center\" :vexpand true :hexpand true :spacing 10 $buf)"
}

workspaces() {
  case "$XDG_CURRENT_DESKTOP" in
  "i3")
    i3_workspaces
    i3-msg -t subscribe -m '{"type":"workspace"}' |
      while read -r _; do
        i3_workspaces
      done
    ;;
  "Hyprland")
    hypr_workspaces
    socat -u UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock - |
      while read -r _; do
        hypr_workspaces
      done
    ;;
  esac
}

workspaces
