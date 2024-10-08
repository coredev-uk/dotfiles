{
  pkgs,
  self,
  hostname,
  lib,
  ...
}:

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
      notify = "${pkgs.dunst}/bin/dunst";
      background = "wallpaper";
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
              ;
          }).resize;
      };
    };

}
