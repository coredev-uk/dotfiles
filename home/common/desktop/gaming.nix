{ pkgs, ... }:
{
  programs.mangohud = {
    enable = true;

    enableSessionWide = true;

    package = pkgs.mangohud;

    settings = { };
  };

  home.packages = with pkgs; [
    mangohud
    lutris
  ];
}
