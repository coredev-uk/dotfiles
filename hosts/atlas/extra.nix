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
  ] ++ lib.optional (desktop == "i3") ./display.nix;

  # Add bootwin script to reboot into Windows
  environment.systemPackages = with pkgs; [
    bootwin
  ];

  # Fix the time when Dual-booting with Windows
  time.hardwareClockInLocalTime = true;
  # time.timeZone = "Europe/London";

  # DNS
  networking.nameservers = [
    "10.147.1.10"
    "10.147.1.20"
  ];
}
