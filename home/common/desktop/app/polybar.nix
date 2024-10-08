{ pkgs, self, ... }:

let
  theme = import "${self}/lib/theme" { inherit pkgs; };
in
{
  services.polybar = {
    enable = true;
    catppuccin.enable = true;

    script = ''
      for m in $(polybar --list-monitors | ${pkgs.coreutils}/bin/cut -d":" -f1); do
        MONITOR=$m polybar -r main &
      done
    '';

    package = pkgs.polybar.override {
      i3Support = true;
      i3 = pkgs.i3;
      alsaSupport = true;
      githubSupport = true;
      pulseSupport = true;
    };

    config = {
      "bar/main" = {
        monitor = "\${env:MONITOR:}";
        width = "100%";

        font-0 = "${theme.fonts.default.name};size=${theme.fonts.default.size};3";
        font-1 = "${theme.fonts.iconFont.name};size=10;3";

        fixed-center = true;
        bottom = false;

        background = "${theme.colours.old.background}"; # "\${colors.crust}";
        foreground = "${theme.colours.old.foreground}"; # "\${colors.text}";

        radius = 9;
        border-size = 5;
        # modules-left = "custom/time custom/date custom/nowplaying custom/weather ui/end ui/start i3/workspaces ui/end";
        modules-center = "i3/window";
        # modules-right = "ui/start tray ui/end ui/start i3/language custom/vpn pulseaudio pulseaudio/microphone";
      };

      # _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_

      "module/root" = {
        format-background = "${theme.colours.old.module}"; # "\${colors.foreground}";
        format-padding = 2;
        format-label-font = 1;
        format-label-padding = 2;
        format-prefix-padding = 2;
        format-prefix-font = 2;
      };

      # _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_

      "module/custom/time" = {
        extends = "module/root";
        format = "%H:%M";
        label = "%time%";
        format-prefix = "";
        format-foreground = "${theme.colours.old.datetime}";
      };

      # _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_

      "module/custom/date" = {
        extends = "module/root";
        format = "%d %b %Y";
        label = "%date%";
        format-prefix = "";
        format-foreground = "${theme.colours.old.datetime}";
      };

      # _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_

      # [module/custom/nowplaying]
      # inherit = module/root
      # type = custom/script
      # format-prefix = 
      # format-prefix-foreground = #625893
      # format-foreground = ${colour.nowplaying}
      # exec = $HOME/dotfiles/scripts/song_formatted.sh polybar
      # scroll-up = "playerctl --player=cider,spotify next"
      # scroll-down = "playerctl --player=cider,spotify previous"
      # click-left = "exec $(playerctl metadata --format '{{playerName}}')"

      "module/i3/window" = {
        extends = "module/root";
        type = "internal/xwindow";
        label = "%title%";
        label-padding = 2;
      };

    };
  };

}
