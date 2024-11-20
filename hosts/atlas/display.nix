{ pkgs, ... }:
{
  # services.xserver.xrandrHeads = [
  #   {
  #     output = "DP-0";
  #     primary = true;
  #   }
  #   {
  #     output = "DP-2";
  #     monitorConfig = ''
  #       Option "LeftOf" "DP-0"
  #     '';
  #   }
  # ];

  services.xserver.displayManager.setupCommands = "${pkgs.xorg.xrandr}/bin/xrandr --output DP-2 --auto --output DP-0 --auto --right-of DP-2 --primary";
}
