_: {
  services.xserver = {
    enable = true;
    windowManager.i3.enable = true;
    videoDrivers = [ "nvidia" ];
  };

  services.displayManager.sddm = {
    enable = true;
  };

}
