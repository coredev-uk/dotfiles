{ pkgs, ... }:
{
  programs.eww = {
    enable = true;

    configDir = ./config;
    enableZshIntegration = true;
  };
}
