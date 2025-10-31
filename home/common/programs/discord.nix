_: {
  # Docs: https://kaylorben.github.io/nixcord/
  programs.nixcord = {
    enable = true;
    vesktop.enable = true;

    config = {
      useQuickCss = true;
      themeLinks = [
        "https://luckfire.github.io/amoled-cord/src/amoled-cord.css"
      ];

      plugins = {
        # to be set
      };
    };
  };
}
