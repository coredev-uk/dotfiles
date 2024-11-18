{
  lib,
  pkgs,
  desktop,
  ...
}:
{
  hardware.pulseaudio.enable = lib.mkForce false;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;

    lowLatency = {
      # enable this module
      enable = true;
      # defaults (no need to be set unless modified)
      quantum = 64;
      rate = 48000;
    };
  };

  environment.systemPackages =
    if (builtins.isString desktop) then
      [
        pkgs.pavucontrol
        pkgs.pamixer
        pkgs.playerctl
      ]
    else
      [ ];
}
