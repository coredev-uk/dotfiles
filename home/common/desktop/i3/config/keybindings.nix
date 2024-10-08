{
  browser,
  screenshot,
  terminal,
  menu,
  lock,
  theme,
  mod,
  pkgs,
  ...
}:
{

  main = {
    ###############################################
    ##### KEYBIND #################################
    ###############################################
    # Media Keys
    "XF86AudioMute" = "exec ${pkgs.pulseaudioFull}/bin/pactl set-source-mute @DEFAULT_SOURCE@ toggle";
    "--release XF86AudioPlay" = "exec ${pkgs.playerctl}/bin/playerctl play-pause";
    "--release XF86AudioNext" = "exec ${pkgs.playerctl}/bin/playerctl next";
    "--release XF86AudioPrev" = "exec ${pkgs.playerctl}/bin/playerctl prev";
    "--release XF86AudioRaiseVolume" = "exec ${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+";
    "--release XF86AudioLowerVolume" = "exec ${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";

    # Screenshot
    "${mod}+Print" = "exec ${screenshot} -u -e 'xclip -selection clipboard -t image/png -i $f && rm $f'";
    "${mod}+Shift+Print" = "exec ${screenshot} -s -e 'xclip -selection clipboard -t image/png -i $f && rm $f'";

    # 1Password
    "${mod}+grave" = "exec ${pkgs._1password-gui}/bin/1password --quick-access";

    # Miscellaneous
    "${mod}+l" = "exec ${lock}";
    "${mod}+b" = "exec ${browser}";
    "${mod}+Return" = "exec ${terminal}";
    "${mod}+space" = "exec ${menu} | xargs i3-msg exec --";
    "${mod}+f2" = "exec ${theme.wallpaper}";

    # WM Controls
    "${mod}+r" = "reload";
    "${mod}+Shift+r" = "restart";
    "${mod}+Shift+q" = "exit";

    # Scratchpad
    "${mod}+c" = "scratchpad show move position center, resize set 80 ppt 70 ppt";
    "${mod}+Shift+c" = "floating enable, resize set 80 ppt 70 ppt, move scratchpad";

    ###############################################
    ##### WINDOW MANAGEMENT #######################
    ###############################################
    "floating_modifier" = "${mod}";

    "${mod}+q" = "kill";
    "${mod}+Shift+space" = "floating toggle; move position center"; # Toggle current container between tiling/floating
    "${mod}+s" = "layout stacking";
    "${mod}+e" = "layout toggle split";
    "${mod}+f" = "fullscreen toggle";

    ###############################################
    ##### FOCUS ###################################
    ###############################################
    "${mod}+Left" = "focus left";
    "${mod}+Right" = "focus right";
    "${mod}+Up" = "focus up";
    "${mod}+Down" = "focus down";

    ###############################################
    ##### RESIZE ##################################
    ###############################################
    "${mod}+Ctrl+Left" = "resize shrink width 10 px or 10 ppt";
    "${mod}+Ctrl+Right" = "resize grow width 10px or 10 ppt";
    "${mod}+Ctrl+Up" = "resize shrink height 10px or 10 ppt";
    "${mod}+Ctrl+Down" = "resize grow height 10px or 10 ppt";

    ###############################################
    ##### TABBED ##################################
    ###############################################
    "${mod}+w" = "layout toggle tabbed split";
    "${mod}+Tab" = "focus right";
    "focus_wrapping" = "force";

    ###############################################
    ##### SWITCH ##################################
    ###############################################
    "${mod}+1" = "workspace number 1";
    "${mod}+2" = "workspace number 2";
    "${mod}+3" = "workspace number 3";
    "${mod}+4" = "workspace number 4";
    "${mod}+5" = "workspace number 5";
    "${mod}+6" = "workspace number 6";
    "${mod}+7" = "workspace number 7";
    "${mod}+8" = "workspace number 8";
    "${mod}+9" = "workspace number 9";
    "${mod}+0" = "workspace number 10";

    ###############################################
    ##### MOVE ####################################
    ###############################################
    "${mod}+Shift+1" = "move container to workspace number 1";
    "${mod}+Shift+2" = "move container to workspace number 2";
    "${mod}+Shift+3" = "move container to workspace number 3";
    "${mod}+Shift+4" = "move container to workspace number 4";
    "${mod}+Shift+5" = "move container to workspace number 5";
    "${mod}+Shift+6" = "move container to workspace number 6";
    "${mod}+Shift+7" = "move container to workspace number 7";
    "${mod}+Shift+8" = "move container to workspace number 8";
    "${mod}+Shift+9" = "move container to workspace number 9";

    ###############################################
    ##### MOUSE BINDINGS ##########################
    ###############################################
    "tiling_drag" = "modifier";
    "${mod}+button4" = "--whole-window focus left";
    "${mod}+button5" = "--whole-window focus right";

    ###############################################
    ##### MOVE FOCUSED ############################
    ###############################################
    "${mod}+Shift+Left" = "move left";
    "${mod}+Shift+Down" = "move down";
    "${mod}+Shift+Up" = "move up";
    "${mod}+Shift+Right" = "move right";
  };

  resize = {
    "Left" = "resize shrink width 10px";
    "Right" = "resize shrink width 10px";
    "Up" = "resize shrink height 10px";
    "Down" = "resize grow height 10px";
    "Return" = "mode 'default'";
    "Escape" = "mode 'default'";
  };
}
