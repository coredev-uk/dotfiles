{ pkgs, ... }:
{
  programs.eww = {
    enable = true;

    configDir = ./config;
    enableZshIntegration = true;
  };

  home.packages = with pkgs; [
    eww
    ffmpeg
  ];

  # scripts
  home.file.".config/eww/scripts/music.sh" = {
    source = ./scripts/music.sh;
    executable = true;
  };

  home.file.".config/eww/scripts/workspace.sh" = {
    source = ./scripts/workspace.sh;
    executable = true;
  };
}
