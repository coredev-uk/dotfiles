{ pkgs, ... }:

{
  home.packages = with pkgs; [
    feh
    cider
    spotify
  ];
}
