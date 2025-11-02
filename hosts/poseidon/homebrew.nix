{
  meta,
  config,
  inputs,
  ...
}:
{
  system.primaryUser = meta.username;

  nix-homebrew = {
    enable = true;
    user = meta.username;
    mutableTaps = false;
    taps = {
      "homebrew/homebrew-core" = inputs.homebrew-core;
      "homebrew/homebrew-cask" = inputs.homebrew-cask;
    };
  };

  homebrew = {
    enable = true;

    taps = builtins.attrNames config.nix-homebrew.taps;

    casks = [
      "batfi"
      "mediamate"
      "raycast"
      "scroll-reverser"
      "alt-tab"
      "bartender"

      "ghostty"

      "onedrive"
      "proton-drive"
      "protonvpn"
      "twingate"

      "windows-app"
    ];
  };
}
