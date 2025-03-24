{
  browser,
  terminal,
  menu,
  self,
  lock,
  mod,
  pkgs,
  ...
}:
let
  theme = import "${self}/lib/theme" { inherit pkgs hostname; };
  inherit (theme) colours fonts;
  wallpaper = pkgs.writeScriptBin "wallpaper" ''
    WALLPAPER_DIR="${theme.wallpaperDir}"
    CURRENT_WALL=$(hyprctl hyprpaper listloaded)

    # Get a random wallpaper that is not the current one
    WALLPAPER=$(find "$WALLPAPER_DIR" -type f ! -name "$(basename "$CURRENT_WALL")" | shuf -n 1)

    # Apply the selected wallpaper
    hyprctl hyprpaper reload ,"$WALLPAPER"
  '';
in
{
  bind =
    [
      # Media Keys
      ", XF86AudioMute, exec, ${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ", XF86AudioPlay, exec, ${pkgs.playerctl}/bin/playerctl play-pause"
      ", XF86AudioPause, exec, ${pkgs.playerctl}/bin/playerctl play-pause"
      ", XF86AudioNext, exec, ${pkgs.playerctl}/bin/playerctl next"
      ", XF86AudioPrev, exec, ${pkgs.playerctl}/bin/playerctl previous"

      # Main Apps
      "${mod}, L, exec, ${lock}"
      "${mod}, B, exec, ${browser}"
      "${mod}, Return, exec, ${terminal}"
      "${mod}, Space, exec, ${menu}"
      "${mod} SHIFT, P, exec, ${wallpaper}/bin/wallpaper"

      # WM Controls
      "${mod}, R, exec, hyprctl reload"
      "${mod} SHIFT, Q, exec, hyprctl dispatch exit"

      # Window Management
      "${mod}, Q, killactive"
      "${mod} SHIFT, Space, togglefloating"
      "${mod}, P, pseudo" # dwindle
      "${mod}, S, togglesplit" # dwindle
      "${mod}, F, fullscreen"

      # Focus
      "${mod}, left, movefocus, l"
      "${mod}, right, movefocus, r"
      "${mod}, up, movefocus, u"
      "${mod}, down, movefocus, d"

      # Resize
      "${mod} CTRL, left, resizeactive, -20 0"
      "${mod} CTRL, right, resizeactive, 20 0"
      "${mod} CTRL, up, resizeactive, 0 -20"
      "${mod} CTRL, down, resizeactive, 0 20"

      # Tabbed
      "${mod}, w, togglegroup"
      "${mod}, tab, changegroupactive"

      # Mouse Movement
      "${mod}, mouse_down, workspace, e+1" # Scroll-Up
      "${mod}, mouse_up, workspace, e-1" # Scroll-Down
    ]
    ++ (
      # workspaces
      # binds ${mod} + [shift +] {1..9} to [move to] workspace {1..9}
      builtins.concatLists (
        builtins.genList (
          i:
          let
            ws = i + 1;
          in
          [
            "${mod}, code:1${toString i}, workspace, ${toString ws}"
            "${mod} SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
          ]
        ) 10
      )
    );

  bindr = [
    # Screenshot
    "${mod}, Print, exec, ${pkgs.grimblast}/bin/grimblast --notify copy active"
    ", Print, exec, ${pkgs.grimblast}/bin/grimblast --notify copy area"

    # 1Password
    "CTRL SHIFT, Space, exec, 1password --quick-access"
  ];

  bindm = [
    "${mod}, mouse:272, movewindow" # Left-Click
    "${mod}, mouse:273, resizewindow" # Right-Click
  ];

  # MultiMedia: Volume Up/Down
  binde = [
    ", XF86AudioRaiseVolume, exec, ${pkgs.wireplumber}/bin/wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"
  ];
  bindl = [
    ", XF86AudioLowerVolume, exec, ${pkgs.wireplumber}/bin/wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%-"
  ];
}
