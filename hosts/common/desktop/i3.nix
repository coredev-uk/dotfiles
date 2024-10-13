{ pkgs, ... }:
{
  services.xserver = {
    enable = true;
    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
    };
    videoDrivers = [ "nvidia" ];
  };

  services.displayManager.sddm = {
    enable = true;
  };

}
