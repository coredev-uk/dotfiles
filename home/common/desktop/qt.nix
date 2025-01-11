{ pkgs, self, ... }:
let
  theme = import "${self}/lib/theme" { inherit pkgs; };
in
{
  qt = {
    enable = true;
    platformTheme.name = "gtk";
  };

  home = {
    packages = with pkgs; [
      theme.qtTheme.package
    ];
  };

  # QT config moved to hosts/common/desktop/qt.nix
  # @see https://github.com/NixOS/nixpkgs/issues/243329

  xdg.configFile = {
    "Kvantum/kvantum.kvconfig".text = ''
      [General]
      theme=${theme.qtTheme.name}
    '';
  };
}
