{
  pkgs,
  self,
  hostname,
  inputs,
  ...
}:
let
  theme = import "${self}/lib/theme" { inherit pkgs hostname; };
in
{
  imports = [
    ../xorg-common.nix

    ./packages.nix
    ./lock.nix
    ./picom.nix
  ];

  home.file.".xinitrc".text = ''
    export XDG_SESSION_TYPE="x11"
    export XDG_SESSION_DESKTOP="i3"
    export XDG_CURRENT_DESKTOP="i3"
    exec i3
  '';

  xsession.windowManager.i3 =
    let
      mod = "Mod4";
      browser = "zen";
      terminal = "${pkgs.ghostty}/bin/ghostty";
      menu = "rofi -show drun";
      lock = "${pkgs.betterlockscreen}/bin/betterlockscreen -l dim";
    in
    {
      enable = true;

      config = {
        inherit terminal;
        modifier = "${mod}";
        bars = [ ];
        gaps = {
          inner = 0;
        };

        # workspaceAutoBackAndForth = true;

        startup = [
          {
            command = ''
              ${pkgs.systemd}/bin/systemctl --user import-environment DISPLAY; \
                ${pkgs.systemd}/bin/systemctl --user start i3-session.target
            '';
            always = false;
            notification = false;
          }
          {
            command = "dbus-update-activation-environment --all";
          }
          {
            # Temporary until xrandrHeads is fixed
            command = "xrandr --output DP-2 --auto --output DP-0 --auto --right-of DP-2 --primary";
          }
          {
            command = "eww open-many bar bar-second";
          }
          {
            command = "${pkgs.feh}/bin/feh --bg-fill ${theme.wallpaper}";
          }
          {
            command = "xset s off";
          }
          {
            command = "xset -dpms";
          }
          {
            command = "xset s noblank";
          }
          {
            command = "1password --silent";
          }
        ];

        fonts = {
          names = [ "${theme.fonts.iconFont.name}" ];
          size = 8.0;
        };

        window = {
          hideEdgeBorders = "smart";
          titlebar = false;
          inherit ((import ./config/window-rules.nix { inherit theme; })) commands;
        };

        floating = {
          border = 1;
          titlebar = false;
        };

        focus = {
          newWindow = "focus";
          followMouse = true;
        };

        keybindings =
          (import ./config/keybindings.nix {
            inherit
              browser
              terminal
              menu
              lock
              theme
              mod
              pkgs
              ;
          }).main;

        modes.resize =
          (import ./config/keybindings.nix {
            inherit
              browser
              terminal
              menu
              lock
              theme
              mod
              pkgs
              ;
          }).resize;
      };
    };

  systemd.user = {
    targets.i3-session = {
      Unit = {
        Description = "i3 session";
        Documentation = [ "man:systemd.special(7)" ];
        BindsTo = [ "graphical-session.target" ];
        Wants = [ "graphical-session-pre.target" ];
        After = [ "graphical-session-pre.target" ];
      };
    };
  };

}
