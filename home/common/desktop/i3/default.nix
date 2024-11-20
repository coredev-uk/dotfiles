{
  pkgs,
  self,
  hostname,
  ...
}:
let
  theme = import "${self}/lib/theme" { inherit pkgs hostname; };
in
{
  imports = [
    ../xorg-common.nix

    ./packages.nix
    ./i3lock.nix
    ./picom.nix
  ];

  home.file.".xinitrc".text = ''
    export XDG_SESSION_TYPE="x11"
    export XDG_SESSION_DESKTOP="i3"
    export XDG_CURRENT_DESKTOP="i3"
    exec i3
  '';

  home.file.".background-image".source = theme.wallpaper;

  xsession.windowManager.i3 =
    let

      mod = "Mod4";
      browser = "zen";
      terminal = "alacritty";
      menu = "rofi -show drun";
      lock = "${pkgs.i3lock-fancy}/bin/i3lock -nef -c 000000";
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
          { command = "xrandr --output DP-2 --auto --output DP-0 --auto --right-of DP-2 --primary"; } # Temporary until xrandrHeads is fixed
          { command = "eww open-many bar bar-second"; }
          { command = "${pkgs.feh}/bin/feh --bg-fill ${theme.wallpaper}"; }
          { command = "xset s off"; }
          { command = "xset -dpms"; }
          { command = "xset s noblank"; }
          { command = "dbus-update-activation-environment --all"; }
          { command = "protonmail-bridge -n"; }
          { command = "gammastep-indicator"; }
        ];

        fonts = {
          names = [ "${theme.fonts.iconFont.name}" ];
          size = 8.0;
        };

        window = {
          hideEdgeBorders = "smart";
          titlebar = false;
          # inherit ((import ./config/window-rules.nix { inherit theme; })) commands;
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

}
