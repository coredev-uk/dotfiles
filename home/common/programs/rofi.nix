{ pkgs, ... }:

{
  catppuccin.rofi.enable = true;

  programs.rofi = {
    enable = true;
    terminal = "${pkgs.ghostty}/bin/ghostty";

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

  home.packages = with pkgs; [
    bemoji
  ];
}
