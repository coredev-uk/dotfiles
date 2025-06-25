{ pkgs, ... }:

let

  clipboard-interop = pkgs.writeScriptBin "clipboard-interop" (
    builtins.readFile ./clipboard-interop.sh
  );
  killwine = pkgs.writeScriptBin "killwine" (builtins.readFile ./killwine.sh);
in
{
  home.packages = [
    clipboard-interop
    killwine
  ];
}
