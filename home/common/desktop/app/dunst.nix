{ pkgs, self, ... }:

let
  theme = import "${self}/lib/theme" { inherit pkgs; };
in
{
  services.dunst = {
    enable = true;

    catppuccin.enable = true;

    settings = {
      global = {
        width = "(300, 500)";
        height = 200;
        origin = "top-right";
        offset = "15x65";

        progress_bar = true;
        progress_bar_height = 10;
        progress_bar_frame_width = 0;
        progress_bar_min_width = 350;
        progress_bar_max_width = 400;

        indicate_hidden = "yes";
        transparency = 0;

        separator_height = 2;
        padding = 12;
        horizontal_padding = 15;
        text_icon_padding = 0;
        frame_width = 2;

        font = "${theme.fonts.default.name}";
        icon_path = "${theme.iconTheme.iconPath}";
      };
    };
  };
}
