{
  pkgs,
  meta,
  ...
}:
{
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;

    extraConfig.pipewire = {
      context.properties = {
        # https://discourse.nixos.org/t/crackling-pipewire/21774/2
        default.clock.allowed-rates = [
          44100
          48000
          96000
        ];
        default.clock.quantum = 256;
        default.clock.min-quantum = 256;
        default.clock.max-quantum = 1024;
      };
    };
  };

  environment.systemPackages =
    if meta.isDesktop then
      [
        pkgs.pwvucontrol
        pkgs.pamixer
        pkgs.playerctl
      ]
    else
      [ ];
}
