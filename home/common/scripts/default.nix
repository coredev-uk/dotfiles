{ pkgs, ... }:

let
  bootwin = pkgs.writeScriptBin "bootwin" (builtins.readFile ./bootwin.sh);
  clipboard-interop = pkgs.writeScriptBin "clipboard-interop" (
    builtins.readFile ./clipboard-interop.sh
  );
  killwine = pkgs.writeScriptBin "killwine" (builtins.readFile ./killwine.sh);
in
{
  home.packages = with pkgs; [
    bootwin
    clipboard-interop
    killwine
  ];
}
