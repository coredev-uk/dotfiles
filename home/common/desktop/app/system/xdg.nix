{ pkgs, username, ... }:
let
  inherit ((import ./file-associations.nix)) associations;
in
{
  xdg = {
    enable = true;
    mimeApps = {
      enable = true;
      defaultApplications = associations;
    };

    # TODO: Make Cider more compatible with nixOS
    desktopEntries = {
      # This is obviously brittle, but works around some difficulties in the (current)
      # distribution model of the Cider beta, where they drop binaries onto itch.io.
      cider = {
        name = "Cider";
        exec = "${pkgs.appimage-run}/bin/appimage-run -- /home/${username}/apps/Cider-1.0.0.AppImage";
        terminal = false;
        icon = "cider";
        type = "Application";
        categories = [
          "Audio"
          "AudioVideo"
          "Application"
        ];
      };
    };
  };
}