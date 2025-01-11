{ pkgs, ... }:
{
  environment = {
    systemPackages = with pkgs; [
      libsForQt5.qtstyleplugin-kvantum
    ];

    sessionVariables = {
      "QT_STYLE_OVERRIDE" = "kvantum";
    };
  };

  qt = {
    enable = true;
    platformTheme = "qt5ct";
    style = "kvantum";
  };
}
