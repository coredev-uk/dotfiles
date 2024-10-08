{ pkgs, ... }:

{
  imports = [
    ./app/dunst.nix
  ];

  home.packages = with pkgs; [
    dunst
    scrot
    dbus
  ];

  services = {
    gnome-keyring.enable = true;
  };

  services.gammastep = {
    enable = true;

    provider = "geoclue2";

    tray = false;

    temperature = {
      day = 5700;
      night = 3500;
    };

    settings = {
      general = {
        gamma = 0.8;
        adjusstment-method = "randr";
      };
    };
  };

  services.xidlehook = {
    enable = true;

    detect-sleep = true;

    not-when-audio = true;
    not-when-fullscreen = true;

    timers = [
      {
        delay = 300;
        command = "loginctl lock-session";
      }
      {
        delay = 300;
        command = "xset s activate";
      }
      {
        delay = 1200;
        command = "systemctl suspend";
      }
    ];
  };

  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    Unit.Description = "polkit-gnome-authentication-agent-1";
    Install.WantedBy = [ "graphical-session.target" ];
    Service = {
      Type = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };
}
