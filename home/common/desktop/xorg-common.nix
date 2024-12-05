{ pkgs, ... }:

{
  imports = [
    ./eww
    # ./polybar
    ./dunst.nix
    ./rofi.nix
  ];

  home.packages = with pkgs; [
    dunst
    libnotify
    scrot
    dbus
  ];

  services = {

    gnome-keyring.enable = true;

    gammastep = {
      enable = true;

      provider = "manual";

      tray = true;

      latitude = 51.50605057576348;
      longitude = -0.131601896747958;

      temperature = {
        day = 5700;
        night = 3500;
      };

      settings = {
        general = {
          # gamma = 0.8;
          adjusstment-method = "randr";
        };
      };
    };

    xidlehook = {
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
  };

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
