_: {
  services.xserver.xrandrHeads = [
    {
      output = "DP-0";
      primary = true;
    }
    {
      output = "DP-2";
      monitorConfig = "Option \"Rotate\" \"left\"";
    }
  ];
}
