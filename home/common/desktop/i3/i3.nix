{ lib, ... }:

let 
  mod = "Mod4";
  browser = "zen";
  terminal = "alacritty";
in 
{
  xsession.windowManager.i3 = {
    enable = true;
    config = {
      terminal = "alacritty";
      modifier = "Mod4";
      
      window = {
        hideEdgeBorders = "smart";
        titlebar = false;
      };

      startup = [
        {
          command = "systemctl restart --user polybar";
        }
      ];

      keybindings = lib.mkOptionDefault {
        "${mod}+space" = "exec rofi -show drun";
        "${mod}+q" = "kill";
      };

      bars = [];
    };

  };

}