{
  lib,
  pkgs,
  desktop,
  ...
}:
{
  # services.pulseaudio.enable = lib.mkForce false;

  services.pipewire = {
    enable = true; # if not already enabled
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;
  };

  environment.systemPackages =
    if (builtins.isString desktop) then
      [
        pkgs.pwvucontrol
        pkgs.pamixer
        pkgs.playerctl
      ]
    else
      [ ];
}
