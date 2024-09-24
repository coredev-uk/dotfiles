{ pkgs, ... }:

{

  # home.packages = with pkgs; [
  #   polybar
  # ];

  services.polybar = {
    enable = true;

    script = "polybar top &";


    package = pkgs.polybar.override {
      i3Support = true;
      i3 = pkgs.i3;
    };

    config = {
      "bar/top" = {
        height = "25";
        modules-left = "i3";
        bottom = true;
        background = "\${colors.crust}";
        foreground = "\${colors.text}";
        font-0 = "Fira Code;size=10;3";
      };


      "module/i3" = {
        type = "internal/i3";
        format = "<label-state> <label-mode>";
        label-mode = "%mode%";
        label-mode-padding = 1;

        label-focused-foreground = "\${colors.lavender}";
        label-focused-background = "\${colors.surface0}";
        label-focused-padding = 1;

        label-unfocused-foreground = "\${colors.foreground}";
        label-unfocused-padding = 1;
      };
    };
  };

}