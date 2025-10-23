{
  self,
  pkgs,
  meta,
  ...
}:
let
  theme = import "${self}/lib/theme" {
    inherit pkgs;
    inherit (meta) hostname;
  };
  inherit (theme) hexToRgb colours;
in
{
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        grace = 5;
        hide_cursor = true;
      };

      background = [
        {
          path = "$HOME/.cache/current-wallpaper.jpg";
          blur_passes = 2;
          blur_size = 6;
        }
      ];

      input-field = [
        {
          size = "250, 60";
          outer_color = "rgb(${hexToRgb colours.black})";
          inner_color = "rgb(${hexToRgb colours.bgDark})";
          font_color = "rgb(${hexToRgb colours.purple})";
          placeholder_text = "";
        }
      ];

      label = [
        {
          text = ''cmd[update:1000] echo "$(date +"%A, %B %d")"'';
          color = "rgba(${hexToRgb colours.text}, 1.0)";
          font_family = theme.fonts.default.name;
          font_size = 64;
          text_align = "center";
          halign = "center";
          valign = "center";
          position = "0, 160";
        }
        {
          text = "$TIME";
          color = "rgba(${hexToRgb colours.subtext1}, 1.0)";
          font_family = theme.fonts.default.name;
          font_size = 32;
          text_align = "center";
          halign = "center";
          valign = "center";
          position = "0, 75";
        }
      ];
    };
  };
}
