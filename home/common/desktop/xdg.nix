_:
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

    # desktopEntries = {
    #   cider = {
    #     name = "Cider";
    #     genericName = "Audio Player";
    #     comment = "A cross-platform Apple Music experience built on Vue.js and written from the ground up with performance in mind.";
    #     exec = "${pkgs.appimage-run}/bin/appimage-run -- /home/${username}/apps/Cider.AppImage";
    #     terminal = false;
    #     icon = "cider";
    #     type = "Application";
    #     categories = [
    #       "Audio"
    #       "Music"
    #       "Player"
    #       "AudioVideo"
    #       "Network"
    #     ];
    #     mimeType = [
    #       "x-scheme-handler/ame"
    #       "x-scheme-handler/cider"
    #       "x-scheme-handler/itms"
    #       "x-scheme-handler/itmss"
    #       "x-scheme-handler/musics"
    #       "x-scheme-handler/music"
    #     ];
    #     actions = {
    #       PlayPause = {
    #         name = "Play-Pause";
    #         exec = "${pkgs.appimage-run}/bin/appimage-run -- /home/${username}/apps/Cider.AppImage --play-pause";
    #       };
    #       Next = {
    #         name = "Next";
    #         exec = "${pkgs.appimage-run}/bin/appimage-run -- /home/${username}/apps/Cider.AppImage --next";
    #       };
    #       Previous = {
    #         name = "Previous";
    #         exec = "${pkgs.appimage-run}/bin/appimage-run -- /home/${username}/apps/Cider.AppImage --previous";
    #       };
    #     };
    #   };
    # };
  };
}
