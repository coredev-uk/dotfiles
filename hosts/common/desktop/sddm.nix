{ pkgs, ... }:

{
  services.displayManager.sddm = {
    enable = true;
    autoNumlock = true;
  };
}
