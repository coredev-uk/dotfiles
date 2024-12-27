{ self, pkgs, ... }:
let
  theme = import "${self}/lib/theme" { inherit pkgs; };
in
{
  home.file.".config/ghostty/config".text = ''
    theme = catppuccin-${theme.catppuccin.flavor}
    font-family = "${theme.fonts.monospace.name}"
  '';
}
