{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    catppuccin-sddm
  ];

  services.displayManager.sddm = {
    enable = true;
    autoNumlock = true;
    theme = "catppuccin-mocha";
  };
}
