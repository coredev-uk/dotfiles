{
  mod,
  terminal,
  menu,
  pkgs,
  ...
}:
{
  main = {
    # Open a terminal
    "${mod}+Return" = "exec ${terminal}";
    # Open the browser
    # "${mod}+b" = "exec ${pkgs.zen-browser}/bin/zen-bin";
    # Toggle the launcher
    "${mod}+space" = "exec ${menu} | xargs i3-msg exec --";
    # Reload the config
    "${mod}+r" = "reload";
    "${mod}+Shift+r" = "restart";
    # Exit i3
    "${mod}+Shift+q" = "exit";
  #   # Lock the screen
  #   # "${mod}+l" = "exec ${pkgs.swaylock-effects}/bin/swaylock -f";
  #   # Kill application
    "${mod}+q" = "kill";

  #   # Screenshots
  #   "Print" = "exec sway-screenshot screen";
  #   "Shift+Print" = "exec sway-screenshot window";
  #   "Alt+Print" = "exec sway-screenshot region";

    # Move focus
    "${mod}+Left" = "focus left";
    "${mod}+Right" = "focus right";
    "${mod}+Up" = "focus up";
    "${mod}+Down" = "focus down";

    # Move windows
    "${mod}+Shift+Left" = "move left";
    "${mod}+Shift+Down" = "move down";
    "${mod}+Shift+Up" = "move up";
    "${mod}+Shift+Right" = "move right";

    # Workspaces
    "${mod}+1" = "workspace number 1";
    "${mod}+2" = "workspace number 2";
    "${mod}+3" = "workspace number 3";
    "${mod}+4" = "workspace number 4";
    "${mod}+5" = "workspace number 5";
    "${mod}+6" = "workspace number 6";
    "${mod}+7" = "workspace number 7";
    "${mod}+8" = "workspace number 8";
    "${mod}+9" = "workspace number 9";

    # Move focused container to workspace
    "${mod}+Shift+1" = "move container to workspace number 1";
    "${mod}+Shift+2" = "move container to workspace number 2";
    "${mod}+Shift+3" = "move container to workspace number 3";
    "${mod}+Shift+4" = "move container to workspace number 4";
    "${mod}+Shift+5" = "move container to workspace number 5";
    "${mod}+Shift+6" = "move container to workspace number 6";
    "${mod}+Shift+7" = "move container to workspace number 7";
    "${mod}+Shift+8" = "move container to workspace number 8";
    "${mod}+Shift+9" = "move container to workspace number 9";

    # Split current object of focus
    "${mod}+h" = "splith";
    "${mod}+v" = "splitv";

    # Switch layout style for current container
    "${mod}+s" = "layout stacking";
    "${mod}+w" = "layout tabbed";
    "${mod}+a" = "layout toggle split";

    # Make current container fullscreen
    "${mod}+f" = "fullscreen";
    # Toggle current container between tiling/floating
    "${mod}+Shift+space" = "floating toggle";
    # Swap focus between tiled windows and floating window
    "Mod1+space" = "focus mode_toggle";
    # Focus parent container
    # "${mod}+a" = "focus parent";
    # Move focused window to scratch pad
    "${mod}+Shift+minus" = "move scratchpad";
    "${mod}+minus" = "scratchpad show";

    "${mod}+c" = "mode 'resize'";

     # Audio/Media Keys
     "--release XF86AudioMute" = "exec ${pkgs.pulseaudioFull}/bin/pactl set-source-mute @DEFAULT_SOURCE@ toggle";
     "--release XF86AudioPlay" = "exec ${pkgs.playerctl}/bin/playerctl play-pause";
     "--release XF86AudioNext" = "exec ${pkgs.playerctl}/bin/playerctl next";
     "--release XF86AudioPrev" = "exec ${pkgs.playerctl}/bin/playerctl prev";

     # Volume Keys
     "--release XF86AudioRaiseVolume" = "exec ${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+";
     "--release XF86AudioLowerVolume" = "exec ${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";

    # Brightness Controls
    # "--locked XF86MonBrightnessUp" = "exec ${pkgs.avizo}/bin/lightctl up";
    # "--locked XF86MonBrightnessDown" = "exec ${pkgs.avizo}/bin/lightctl down";

     # Applications
     "Mod1+grave" = "exec ${pkgs._1password-gui}/bin/1password --quick-access";
    #  "${mod}+c" = "exec sway-clip";
    #  "${mod}+e" = "exec bemoji -c -n";
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