{ pkgs, self, ... }:

let
  theme = import "${self}/lib/theme" { inherit pkgs; };
  weather = pkgs.writeScriptBin "get-weather" ''
    #!/bin/sh

    BAR_TYPE=$1

    weather=$(${pkgs.curl}/bin/curl -s "https://wttr.in?format=1")
    if [[ "$weather" == *"Unknown"* ]] || [[ "$weather" == *"Error"* ]]; then
      exit
    fi

    text=$(echo "$weather" | ${pkgs.gnused}/bin/sed -E "s/\s+/ /g")
    tooltip="hey"

    if [ "$BAR_TYPE" == "polybar" ]; then
      echo $text
    elif [ "$BAR_TYPE" == "waybar" ]; then
      echo "{\"text\":\"$text\", \"tooltip\":\"$tooltip\"}"
    else
      echo "Unsupported Bar"
    fi    
  '';
  nowplaying = pkgs.writeScriptBin "get-nowplaying" ''
    #!/bin/sh
    barType=$1

    escaped_artist=$(${pkgs.playerctl}/bin/playerctl metadata --player=cider,spotify --format '{{markup_escape(artist)}}' 2>&1)
    escaped_title=$(${pkgs.playerctl}/bin/playerctl metadata --player=cider,spotify --format '{{markup_escape(title)}}' 2>&1)
    escaped_album=$(${pkgs.playerctl}/bin/playerctl metadata --player=cider,spotify --format '{{markup_escape(album)}}' 2>&1)

    artist=$(${pkgs.playerctl}/bin/playerctl metadata --player=cider,spotify --format '{{artist}}' 2>&1)
    title=$(${pkgs.playerctl}/bin/playerctl metadata --player=cider,spotify --format '{{title}}' 2>&1)
    album=$(${pkgs.playerctl}/bin/playerctl metadata --player=cider,spotify --format '{{album}}' 2>&1)

    player=$(${pkgs.playerctl}/bin/playerctl metadata --format '{{playerName}}' 2>&1)

    if [[ "$artist" != "No players found" && "$artist" != "No player could handle this command" && "$(${pkgs.playerctl}/bin/playerctl status 2>&1)" == "Playing" ]]; then
    	if [[ $barType == "waybar" ]]; then
    		echo '{"text": "'$escaped_artist' [ <span color=\"#fff\">'$escaped_title'</span> ]", "class": "custom-nowplaying", "alt": "'$player'", "tooltip": "'$escaped_album'"}'
    	elif [[ $barType == "polybar" ]]; then
    		echo "$artist %{F#fff}[ $title ]%{F-}"
    	fi
    else
    	echo ""
    fi
  '';
  microphone = pkgs.writeScriptBin "get-microphone" ''
    #!/bin/sh

    get_mic_default() {
        ${pkgs.pulseaudio}/bin/pactl info | awk '/Default Source:/ {print $3}'
    }

    is_mic_muted() {
        ${pkgs.pulseaudio}/bin/pactl get-source-mute "$(get_mic_default)" | awk '{print $2}'
    }

    get_mic_status() {
        if [ "$(is_mic_muted)" = "yes" ]; then
            echo "  Muted"
        else
            echo " $(${pkgs.pamixer}/bin/pamixer --default-source --get-volume)%"
        fi
    }

    listen() {
        get_mic_status
        LANG=EN; ${pkgs.pulseaudio}/bin/pactl subscribe | while read -r event; do
            if printf "%s\n" "$\{event}" | ${pkgs.gnugrep}/bin/grep -qE '(source|server)'; then
                get_mic_status
            fi
        done
    }

    toggle() {
        ${pkgs.pulseaudio}/bin/pactl set-source-mute @DEFAULT_SOURCE@ toggle
    }

    case "$\{1}" in
        --toggle)
            toggle
            ;;
        *)
            listen
            ;;
    esac
  '';
in
{
  services.polybar = {
    enable = true;
    catppuccin.enable = true;

    script = ''
      for m in $(polybar --list-monitors | ${pkgs.coreutils}/bin/cut -d":" -f1); do
        MONITOR=$m polybar -r main &
      done
    '';

    package = pkgs.polybar.override {
      i3Support = true;
      inherit (pkgs) i3;
      alsaSupport = true;
      githubSupport = true;
      pulseSupport = true;
    };

    config = {
      "bar/main" = {
        monitor = "\${env:MONITOR:}";
        width = "100%";

        font-0 = "${theme.fonts.default.name};size=${theme.fonts.default.size};3";
        font-1 = "${theme.fonts.iconFont.name};size=10;3";

        fixed-center = true;
        bottom = false;

        background = "${theme.colours.old.background}"; # "\${colors.crust}";
        foreground = "${theme.colours.old.foreground}"; # "\${colors.text}";

        radius = 9;
        border-size = 5;
        modules-left = "custom/time custom/date custom/nowplaying custom/weather ui/end ui/start i3/workspaces ui/end";
        modules-center = "i3/window";
        modules-right = "ui/start tray ui/end ui/start i3/language pulseaudio pulseaudio/microphone";
      };

      "module/ui/root" = {
        type = "custom/text";
        format-font = 3;
        format-background = "${theme.colours.old.background}";
        format-foreground = "${theme.colours.old.module}";
      };

      "module/ui/start" = {
        "inherit" = "module/ui/root";
        format-padding = 4;
        format = "";
      };

      "module/ui/end" = {
        "inherit" = "module/ui/root";
        format = "";
      };

      # _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_

      "module/root" = {
        format-background = "${theme.colours.old.module}"; # "\${colors.foreground}";
        format-padding = 2;
        format-label-font = 1;
        format-label-padding = 2;
        format-prefix-padding = 2;
        format-prefix-font = 2;
      };

      # _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_

      "module/custom/time" = {
        "inherit" = "module/root";
        type = "internal/date";
        time = "%H:%M";
        label = "%time%";
        format-prefix = "";
        format-foreground = "${theme.colours.old.datetime}";
      };

      # _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_

      "module/custom/date" = {
        "inherit" = "module/root";
        type = "internal/date";
        date = "%d %b %Y";
        label = "%date%";
        format-prefix = "";
        format-foreground = "${theme.colours.old.datetime}";
      };

      # _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_

      "module/custom/nowplaying" = {
        "inherit" = "module/root";
        type = "custom/script";
        format-prefix = "";
        format-prefix-foreground = "#625893";
        format-foreground = "${theme.colours.old.nowplaying}";
        exec = "${nowplaying}/bin/get-nowplaying polybar";
        scroll-up = "playerctl --player=cider,spotify next";
        scroll-down = "playerctl --player=cider,spotify previous";
        click-left = "exec $(playerctl metadata --format '{{playerName}}')";
      };

      # _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_

      "module/custom/weather" = {
        "inherit" = "module/root";
        type = "custom/script";
        exec = "${weather}/bin/get-weather polybar";
        interval = 600;
        format-font = 3;
        format-padding = 3;
      };

      # _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_

      "module/i3/workspaces" = {
        "inherit" = "module/root";
        type = "internal/i3";

        pin-workspaces = true;
        strip-wsnumbers = true;
        index-sort = true;

        format = "<label-state> <label-mode>";
        format-padding = 0;
        format-background = "${theme.colours.old.module}";

        label-mode = "[ %mode% ]";
        label-mode-underline = "#FF3B30";
        label-mode-background = "${theme.colours.old.module}";

        label-focused = "%index%";
        label-focused-padding = 4;
        label-focused-foreground = "#a6adc8";
        label-focused-background = "${theme.colours.old.module}";

        label-unfocused = "%index%";
        label-unfocused-padding = 4;
        label-unfocused-foreground = "#313244";
        label-unfocused-background = "${theme.colours.old.module}";

        label-visible = "%index%";
        label-visible-padding = 4;
        label-visible-foreground = "#a6adc8";
        label-visible-background = "${theme.colours.old.module}";

        label-urgent = "%index%";
        label-urgent-padding = 4;
        label-urgent-foreground = "#11111b";
        label-urgent-background = "#a6e3a1";
      };

      # _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_

      "module/i3/window" = {
        "inherit" = "module/root";
        type = "internal/xwindow";
        label = "%title%";
        label-padding = 2;
      };

      # _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_

      "module/tray" = {
        "inherit" = "module/root";
        type = "internal/tray";
        tray-foreground = "${theme.colours.old.caffeine}";
        tray-background = "${theme.colours.old.module}";
        tray-padding = "4px";
      };

      # _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_

      "module/i3/language" = {
        "inherit" = "module/root";
        type = "internal/xkeyboard";
        label-layout = "%name%";
        format-prefix = " ";
        format-foreground = "${theme.colours.old.language}";
      };

      # _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_

      "module/pulseaudio" = {
        "inherit" = "module/root";
        type = "internal/pulseaudio";

        format-volume-padding = 2;
        format-volume-foreground = "${theme.colours.old.volume}";
        format-volume-background = "${theme.colours.old.module}";

        format-muted-padding = 2;
        format-muted-foreground = "${theme.colours.old.volume}";
        format-muted-background = "${theme.colours.old.module}";

        format-volume = "<ramp-volume> <label-volume>";
        label-muted = " Muted";
        ramp-volume-0 = "";
        ramp-volume-1 = "";
        ramp-volume-2 = "";

        click-right = "${lib.getExe pkgs.pwvucontrol}";
      };

      # _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_

      "module/pulseaudio/microphone" = {
        "inherit" = "module/root";
        type = "custom/script";
        exec = "${microphone}/bin/get-microphone";
        format-foreground = "${theme.colours.old.microphone}";
        tail = true;
        click-left = "pamixer --default-source --toggle-mute";
        scroll-up = "pamixer --default-source -i 5";
        scroll-down = "pamixer --default-source -d 5";
      };

    };
  };

}
