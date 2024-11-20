{ pkgs, ... }:
{

  # TODO: ProtonDrive setup with age
  home.packages = with pkgs; [ rclone ];

}
