{
  pkgs,
  lib,
  self,
  ...
}:
let
  theme = import "${self}/lib/theme" { inherit pkgs; };
  i3-run = pkgs.writeShellScriptBin "i3-run" ''
    export XDG_SESSION_TYPE="x11"
    export XDG_SESSION_DESKTOP="i3"
    export XDG_CURRENT_DESKTOP="i3"
    export GTK_THEME=${theme.gtkTheme.name}

    startx
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

  services.greetd.settings.default_session.command = ''
    ${lib.makeBinPath [ pkgs.greetd.tuigreet ]}/tuigreet -r --asterisks --time \
      --cmd ${lib.getExe i3-run}
  '';
}
