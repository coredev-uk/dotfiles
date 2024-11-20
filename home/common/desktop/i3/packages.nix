{ pkgs, ... }:

{
  home.packages = with pkgs; [
    scrot
    feh
  ];
}
