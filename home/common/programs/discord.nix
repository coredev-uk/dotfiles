_: {
  # Docs: https://kaylorben.github.io/nixcord/
  programs.nixcord = {
    enable = true;

    discord = {
      enable = true;
      openASAR.enable = true;
      vencord = {
        enable = true;
        unstable = false;
      };
    };

    config = {
      useQuickCss = true;
      themeLinks = [
        "https://luckfire.github.io/amoled-cord/src/amoled-cord.css"
      ];

      plugins = {
        autoDNDWhilePlaying.enable = true;

        disableCallIdle.enable = true;

        fixCodeblockGap.enable = true;
        fixSpotifyEmbeds.enable = true;

        messageLogger.enable = true;
        openInApp.enable = true;

        shikiCodeblocks.enable = true;
        sortFriendRequests.enable = true;

        translate.enable = true;
        validUser.enable = true;

        youtubeAdblock.enable = true;
      };
    };
  };
}
