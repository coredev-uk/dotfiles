{
  pkgs,
  lib,
  self,
  ...
}:
let
  theme = import "${self}/lib/theme" { inherit pkgs; };
  i3-run = pkgs.writeShellScriptBin "i3-run" ''
    export GTK_THEME=${theme.gtkTheme.name}

    systemctl --user import-environment PATH DISPLAY XAUTHORITY DESKTOP_SESSION XDG_CONFIG_DIRS XDG_DATA_DIRS XDG_RUNTIME_DIR XDG_SESSION_ID DBUS_SESSION_BUS_ADDRESS
    dbus-update-activation-environment --systemd --all

    ${pkgs.xorg.xinit}/bin/startx
  '';
in
{
  imports = [ ./tiling-common.nix ];

  services.xserver = {
    enable = true;

    desktopManager.wallpaper.mode = "fill";
    displayManager.startx.enable = true;

    videoDrivers = [ "nvidia" ];

    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
    };
  };

  systemd.services.i3 = {
    description = "i3 tiling window manager";
    script = "${lib.getExe i3-run}";
  };

  services.greetd.settings.default_session.command = lib.concatStringsSep " " [
    "${pkgs.tuigreet}/bin/tuigreet"
    "--remember"
    "--asterisks"
    "--time"
    "--cmd ${lib.getExe i3-run}"
  ];
}
