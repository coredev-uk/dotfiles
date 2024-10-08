{
  pkgs,
  self,
  hostname,
  ...
}:

let
  wallpaper = pkgs.writeScriptBin "wallpaper" ''
    #!/bin/sh
    directory=~/.wallpapers

    if [ ! -d "$directory" ]; then
        echo "Directory does not exist."
        exit
    fi

    random_background=$(ls $directory/* | shuf -n 1)

    if [ "$XDG_SESSION_TYPE" = "x11" ]; then
        DISPLAY=:0.0 ${pkgs.feh}/bin/feh --bg-fill $random_background
    elif [ "$XDG_SESSION_TYPE" = "wayland" ]; then
        monitors=$(hyprctl monitors | grep Monitor | awk '{print $2}')

        if ! $(pgrep -x hyprpaper &>2); then
            ${pkgs.hyprpaper}/bin/hyprpaper &
        fi

        hyprctl hyprpaper unload all
        hyprctl hyprpaper preload $random_background
        for monitor in $monitors; do
            hyprctl hyprpaper wallpaper "$monitor, $random_background"
        done
    else
        echo "Unsupported Environment"
        exit
    fi
  '';
in
{
  imports = [
    ../xorg-common.nix
    ./packages.nix
  ];

  xsession.windowManager.i3 =
    let
      theme = import "${self}/lib/theme" { inherit pkgs hostname; };
      mod = "Mod4";
      browser = "zen-bin";
      screenshot = "${pkgs.scrot}/bin/scrot";
      terminal = "alacritty";
      menu = "rofi -show drun";
      lock = "${pkgs.i3lock}/bin/i3lock -nef -c 000000";
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

        startup = [
          {
            command = "systemctl restart --user polybar";
          }
        ];

        keybindings =
          (import ./config/keybindings.nix {
            inherit
              browser
              screenshot
              terminal
              menu
              lock
              theme
              mod
              pkgs
              wallpaper
              ;
          }).main;

        modes.resize =
          (import ./config/keybindings.nix {
            inherit
              browser
              screenshot
              terminal
              menu
              lock
              theme
              mod
              pkgs
              wallpaper
              ;
          }).resize;
      };
    };

}
