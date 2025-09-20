{
  self,
  pkgs,
  ...
}:
let
  theme = import "${self}/lib/theme" { inherit pkgs; };
in
{
  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      theme = "Catppuccin Mocha";
      font-family = theme.fonts.monospace.name;
      window-decoration = false;
      clipboard-paste-protection = false;
    };
  };
}
