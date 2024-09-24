{
  pkgs,
  lib,
  self,
  ...
}:
let
  theme = import "${self}/lib/theme" { inherit pkgs; };
in
{
    services.xserver = {
        enable = true;
        windowManager.i3.enable = true;
    };

    services.displayManager.sddm = {
      enable = true;
    };

}
