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
}
