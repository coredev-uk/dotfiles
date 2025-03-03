{ pkgs, ... }:
{
  imports = [
    (lib.optional (builtins.pathExists ./. + "/${hostname}.nix") (import ./. + "/${hostname}.nix"))
  ];

  # Temporary
  home.packages = with pkgs; [
    kitty
  ];
  programs.kitty.enable = true; # required for the default Hyprland config
  wayland.windowManager.hyprland.enable = true; # enable Hyprland

  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";

    general = {
      gaps_in = 0; # 5
      gaps_out = 0; # 5
      border_size = 2; # 0

      no_border_on_floating = true;

      # "col.active_border" = "rgba(f2cdcdff) rgba(cba6f7ff) 45deg";
      # "col.inactive_border" = "rgba(595959aa)";

      allow_tearing = false;
      layout = "dwindle";
    };

    input = {
      kb_layout = "gb";
      follow_mouse = 1;
      sensitivity = 0;
      force_no_accel = true;
    };

    decoration = {
      # Rounding
      rounding = 4;

      # Opacity
      active_opacity = 1.0;
      inactive_opacity = 0.95;

      # Blur
      blur = {
        enabled = true;
        size = 3;
        passes = 2;
        new_optimizations = true;
      };

      # Shadow
      drop_shadow = true;
      shadow_ignore_window = true;
      shadow_range = 4;
      shadow_render_power = 2;
      col.shadow = 0 x66000000;
    };

    exec-once = [
      "eww open-many bar bar1 bar2"
      "lxqt-policykit-agent"
    ];

    layerrule = [
      "blur, bar"
    ];

    bezier = [
      "mycurve,.32,.97,.53,.98"
    ];

    animations = {
      enabled = 0;
      animation = [
        "windowsMove,1,4,mycurve"
        "windowsIn,1,4,mycurve"
        "windowsOut,0,4,mycurve"
      ];
    };

    debug = {
      disable_logs = true;
    };

    bind =
      [
        ", Print, exec, ~/scripts/screenshot"
        "$mod, Return, exec, ghostty"
        "$mod SHIFT, Q, killactive"
        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"
        "$mod SHIFT, left, movewindow, l"
        "$mod SHIFT, right, movewindow, r"
        "$mod SHIFT, up, movewindow, u"
        "$mod SHIFT, down, movewindow, d"
        "$mod, d, exec, wofi --show run"
        "$mod SHIFT, e, exit"
        "$mod, l, exec, hyprlock"
        "$mod, mouse:272, movewindow"
        "$mod, f, fullscreen"
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"

      ]
      ++ (
        # workspaces
        # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
        builtins.concatLists (
          builtins.genList (
            i:
            let
              ws = i + 1;
            in
            [
              "$mod, code:1${toString i}, workspace, ${toString ws}"
              "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
            ]
          ) 10
        )
      );
  };

  # Optional, hint Electron apps to use Wayland:
  home.sessionVariables.NIXOS_OZONE_WL = "1";
}
