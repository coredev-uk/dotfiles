{
  self,
  desktop,
  lib,
  pkgs,
  ...
}:
let
  bootwin = pkgs.writeScriptBin "bootwin" ''
    #!/bin/sh
    sudo su - <<EOF
    efibootmgr -n 0000
    reboot
    EOF
  '';
in
{
  imports = [
    "${self}/hosts/common/services/networkmanager.nix"
    "${self}/hosts/common/desktop/gaming.nix"
    "${self}/hosts/common/desktop/rgb.nix"
    "${self}/hosts/common/desktop/qmk.nix"
    "${self}/hosts/common/base/nix-ld.nix"
  ] ++ lib.optional (desktop == "i3") ./display.nix;

  # Add bootwin script to reboot into Windows
  environment.systemPackages = [
    bootwin
  ];

  # Fix the time when Dual-booting with Windows
  # time.hardwareClockInLocalTime = true;
  time.timeZone = "Europe/London";

  # DNS
  networking.nameservers = [
    "10.147.1.10"
    "10.147.1.20"
  ];

  #systemd.extraConfig = "DefaultLimitNOFILE=1048576";

  # Fix hmr issue (https://github.com/phenax/nixos-dotfiles/blob/main/configuration.nix#L34)
  systemd.extraConfig = ''DefaultLimitNOFILE=524288'';
  systemd.user.extraConfig = ''DefaultLimitNOFILE=524288'';
  boot.kernel.sysctl."fs.inotify.max_user_instances" = 8192;
  security.pam.loginLimits = [
    {
      domain = "*";
      type = "-";
      item = "nofile";
      value = "524288";
    }
  ];

  # Disable suspend of Toslink output to prevent audio popping.
  services.pipewire.wireplumber.extraConfig."99-disable-suspend" = {
    "monitor.alsa.rules" = [
      {
        matches = [
          {
            "node.name" = "alsa_output.usb-Generic_ATH-M50xSTS-USB-00.analog-stereo";
          }
        ];
        actions = {
          update-props = {
            "session.suspend-timeout-seconds" = 0;
          };
        };
      }
    ];
  };
}
