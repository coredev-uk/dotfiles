{ pkgs, self, ... }:

let
  theme = import "${self}/lib/theme" { inherit pkgs; };

  clipboard-interop = pkgs.writeScriptBin "clipboard-interop" (
    builtins.readFile ./clipboard-interop.sh
  );
  killwine = pkgs.writeScriptBin "killwine" (builtins.readFile ./killwine.sh);
in
{
  home.packages = with pkgs; [
    clipboard-interop
    killwine
  ];
}
