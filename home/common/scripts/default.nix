{ pkgs, ... }:

let
  bootwin = pkgs.writeScriptBin "bootwin" (builtins.readFile ./bootwin.sh);
  clipboard-interop = pkgs.writeScriptBin "clipboard-interop" (
    builtins.readFile ./clipboard-interop.sh
  );
  get-weather = pkgs.writeScriptBin "get-weather" (builtins.readFile ./get-weather.sh);
  killwine = pkgs.writeScriptBin "killwine" (builtins.readFile ./killwine.sh);
  microphone = pkgs.writeScriptBin "microphone" (builtins.readFile ./microphone.sh);
  nowplaying = pkgs.writeScriptBin "nowplaying" (builtins.readFile ./nowplaying.sh);
  vpn = pkgs.writeScriptBin "vpn" (builtins.readFile ./vpn.sh);
  wallpaper = pkgs.writeScriptBin "wallpaper" (builtins.readFile ./wallpaper.sh);
in
{
  home.packages = with pkgs; [
    bootwin
    clipboard-interop
    get-weather
    killwine
    microphone
    nowplaying
    vpn
    wallpaper
  ];
}
