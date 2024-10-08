{ pkgs, desktop, ... }:

{
  programs.rofi = {
    enable = true;
    package = if desktop == "i3" then pkgs.rofi else pkgs.rofi-wayland;
    catppuccin = {
      enable = true;
      flavor = "mocha";
    };
    terminal = "${pkgs.alacritty}/bin/alacritty";

    extraConfig = {
      modi = "drun";
      show-icons = true;
      drun-display-format = "{icon} {name}";
      disable-history = false;
      hide-scrollbar = true;
      display-drun = "   Apps ";
      sidebar-mode = true;
    };
  };

  home.packages = [ pkgs.bemoji ];
}
