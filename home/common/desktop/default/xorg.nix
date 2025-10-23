{ pkgs, ... }:

{
  imports = [
    ../../programs/eww
    # ../../programs/picom.nix
    ../../programs/dunst.nix
    ../../programs/rofi.nix
  ];

  home.packages = with pkgs; [
    feh
    libnotify
    scrot
    dbus
  ];

  fonts.fontconfig.enable = true;
  services.gnome-keyring.enable = true;

  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    Unit = {
      Description = "GNOME Polkit Authentication Agent";
      PartOf = [ "graphical-session-pre.target" ];
    };

    Install = {
      WantedBy = [ "graphical-session-pre.target" ];
    };

    Service = {
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-abort";
    };
  };
}
