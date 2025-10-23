{ pkgs, self, ... }:
let
  theme = import "${self}/lib/theme" { inherit pkgs; };
in
{
  qt = {
    enable = true;
    platformTheme.name = "qtct";
    style.name = "kvantum";
  };

  home = {
    packages = [
      theme.qtTheme.package
    ];
  };

  # QT config moved to hosts/common/desktop/qt.nix
  # @see https://github.com/NixOS/nixpkgs/issues/243329

  xdg.configFile."Kvantum/kvantum.kvconfig".source =
    (pkgs.formats.ini { }).generate "kvantum.kvconfig"
      {
        General.theme = "${theme.qtTheme.name}";
      };

  xdg.configFile."qt5ct/qt5ct.conf".source = (pkgs.formats.ini { }).generate "kvantum.kvconfig" {
    Appearance.icon_theme = "${theme.iconTheme.name}";
  };
}
