{ pkgs, ... }:
{
  programs.mangohud = {
    enable = true;

    enableSessionWide = true;

    package = pkgs.mangohud;

    settings = {
      table_columns = 2;
      hud_compact = true;
      gpu_stats = true;
      cpu_stats = true;
      fps = true;
      frametime = false;
      frame_timing = false;
      round_corners = 3;
      width = 100;
    };
  };

  home.packages = with pkgs; [
    mangohud
    lutris
  ];
}
