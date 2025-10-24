{ pkgs, self, ... }:

let
  theme = import "${self}/lib/theme" { inherit pkgs; };
in
{
  catppuccin.swaync = {
    enable = true;
    font = theme.fonts.default.name;
  };

  services.swaync = {
    enable = true;
    package = pkgs.swaynotificationcenter;

    settings = {
      positionX = "right";
      positionY = "top";
      layer = "overlay";
      control-center-layer = "top";
      # layer-shell = true;
      # cssPriority = "application";
      control-center-margin-top = 0;
      control-center-margin-bottom = 0;
      control-center-margin-right = 0;
      control-center-margin-left = 0;
      # notification-2fa-action = true;
      # notification-inline-replies = false;
      notification-icon-size = 64;
      notification-body-image-height = 100;
      notification-body-image-width = 200;
      timeout = 10;
      timeout-low = 5;
      timeout-critical = 0;
      fit-to-screen = true;
      control-center-width = 500;
      control-center-height = 600;
      notification-window-width = 500;
      keyboard-shortcuts = true;
      image-visibility = "when-available";
      # transition-time = 200;
      hide-on-clear = false;
      hide-on-action = true;
      script-fail-notify = false;
    };
  };
}
