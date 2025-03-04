{ pkgs, ... }:

{
  imports = [
    ./eww
    ./dunst.nix
    ./rofi.nix
  ];

  home.packages = with pkgs; [
    libnotify
    scrot
    dbus
    wl-clipboard
    wdisplays
  ];

  services = {

    gnome-keyring.enable = true;

    wlsunset = {
      enable = true;
      latitude = "51.50605057576348";
      longitude = "-0.131601896747958";
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

  home.sessionVariables = {
    _JAVA_AWT_WM_NONREPARENTING = "1";
    CLUTTER_BACKEND = "wayland";
    GDK_BACKEND = "wayland";
    MOZ_ENABLE_WAYLAND = "1";
    QT_QPA_PLATFORM = "wayland";
    # QT_QPA_PLATFORMTHEME = "qt5ct";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    SDL_VIDEODRIVER = "wayland";
    XDG_SESSION_TYPE = "wayland";
    NIXOS_OZONE_WL = "1";
  };
}
