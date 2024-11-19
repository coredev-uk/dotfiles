{
  pkgs,
  lib,
  self,
  ...
}:
let
  theme = import "${self}/lib/theme" { inherit pkgs; };
in
# ${pkgs.i3}/bin/i3-msg exit
{
  imports = [ ./tiling-common.nix ];

  home.file.".xinitrc".text = ''
    #!/bin/sh
    export XDG_SESSION_TYPE="x11"
    export XDG_SESSION_DESKTOP="i3"
    export XDG_CURRENT_DESKTOP="i3"
    export GTK_THEME=${theme.gtkTheme.name}

    exec i3
  '';

  services.xserver = {
    enable = true;
    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
    };
    displayManager.startx.enable = true;
    videoDrivers = [ "nvidia" ];
  };

  services.greetd.settings.default_session.command = ''
    ${lib.makeBinPath [ pkgs.greetd.tuigreet ]}/tuigreet -r --asterisks --time \
      --cmd startx
  '';
}
